package mobi.lat.app.miguel.data

import com.squareup.moshi.Moshi
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import mobi.lat.app.miguel.models.Comment
import com.squareup.moshi.Types
import io.flutter.plugin.common.MethodChannel
import okhttp3.Call
import okhttp3.Callback
import okhttp3.Response
import java.io.IOException

class CommentRepository(private val apiService: ApiService) {

    private val moshi: Moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
    private val jsonAdapter = moshi.adapter<List<Comment>>(Types.newParameterizedType(List::class.java, Comment::class.java))

    fun getComments(postId: Int, result: MethodChannel.Result) {
        apiService.fetchComments(postId, object : Callback {
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
