import Foundation

class JSONConverter {
    
    static func convertCommentsToJson(_ comments: [Comment]) -> [[String: Any]] {
        return comments.map { comment in
            [
                "postId": comment.postId,
                "id": comment.id,
                "name": comment.name,
                "email": comment.email,
                "body": comment.body
            ]
        }
    }
}
