package mobi.lat.app.miguel.data

import okhttp3.*
import java.io.IOException

class ApiService(private val client: OkHttpClient) {

    fun fetchComments(postId: Int, callback: Callback) {
        val url = "https://jsonplaceholder.typicode.com/comments?postId=$postId"
        val request = Request.Builder().url(url).build()
        client.newCall(request).enqueue(callback)
    }
}