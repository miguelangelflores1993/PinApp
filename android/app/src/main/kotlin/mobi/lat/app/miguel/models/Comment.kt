package mobi.lat.app.miguel.models

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class Comment(
    val postId: Int,
    val id: Int,
    val name: String,
    val email: String,
    val body: String
)