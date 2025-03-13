package mobi.lat.app.miguel

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import mobi.lat.app.miguel.data.ApiService
import mobi.lat.app.miguel.data.CommentRepository
import mobi.lat.app.miguel.models.Comment
import okhttp3.OkHttpClient

class MainActivity : FlutterActivity() {

    private val CHANNEL = "comments_channel"
    private val client = OkHttpClient()
    private val apiService = ApiService(client)
    private val commentRepository = CommentRepository(apiService)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getComments") {
                val postId = call.argument<Int>("postId")
                if (postId != null) {
                    commentRepository.getComments(postId, result)
                } else {
                    result.error("INVALID_ARGUMENT", "Invalid postId", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
