package mobi.lat.app.miguel

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import mobi.lat.app.miguel.models.Comment
import okhttp3.*
import com.squareup.moshi.*
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "comments_channel"
    private val client = OkHttpClient()
    private val moshi: Moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
    private val jsonAdapter = moshi.adapter<List<Comment>>(Types.newParameterizedType(List::class.java, Comment::class.java))

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getComments") {
                val postId = call.argument<Int>("postId")
                if (postId != null) {
                    fetchComments(postId, result)
                } else {
                    result.error("INVALID_ARGUMENT", "Invalid postId", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun fetchComments(postId: Int, result: MethodChannel.Result) {
        val url = "https://jsonplaceholder.typicode.com/comments?postId=$postId"
        val request = Request.Builder().url(url).build()

        client.newCall(request).enqueue(object : Callback {
            override fun onFailure(call: Call, e: IOException) {
                result.error("NETWORK_ERROR", e.localizedMessage, null)
            }

            override fun onResponse(call: Call, response: Response) {
                response.body?.string()?.let { responseBody ->
                    try {
                        val commentsList: List<Comment>? = jsonAdapter.fromJson(responseBody)
                        if (commentsList != null) {
                            result.success(commentsList.map { comment ->
                                mapOf(
                                    "postId" to comment.postId,
                                    "id" to comment.id,
                                    "name" to comment.name,
                                    "email" to comment.email,
                                    "body" to comment.body
                                )
                            })
                        } else {
                            result.error("JSON_PARSING_ERROR", "Failed to parse JSON", null)
                        }
                    } catch (e: Exception) {
                        result.error("JSON_PARSING_ERROR", "Failed to parse JSON", e.localizedMessage)
                    }
                } ?: result.error("NO_DATA", "No data received", null)
            }
        })
    }
}
