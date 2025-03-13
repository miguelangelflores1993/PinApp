import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "comments_channel",
                                           binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "getComments" {
                guard let args = call.arguments as? [String: Any],
                      let postId = args["postId"] as? Int else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid postId", details: nil))
                    return
                }
                // Llamar a la función para obtener los comentarios
                self.fetchComments(postId: postId, result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        // Llamar al método padre para asegurar que se inicie la aplicación correctamente
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func fetchComments(postId: Int, result: @escaping FlutterResult) {
        let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        guard let url = URL(string: urlString) else {
            result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
            return
        }


        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                result(FlutterError(code: "NETWORK_ERROR", message: error.localizedDescription, details: nil))
                return
            }

        
            guard let data = data else {
                result(FlutterError(code: "NO_DATA", message: "No data received", details: nil))
                return
            }

            let decoder = JSONDecoder()
            do {
                let comments = try decoder.decode([Comment].self, from: data)
              
                let commentsJson = self.convertCommentsToJson(comments)
                result(commentsJson)
            } catch {
                result(FlutterError(code: "JSON_ERROR", message: "Failed to decode JSON", details: error.localizedDescription))
            }
        }

        task.resume()
    }
    
 
    private func convertCommentsToJson(_ comments: [Comment]) -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        for comment in comments {
            let dict: [String: Any] = [
                "postId": comment.postId,
                "id": comment.id,
                "name": comment.name,
                "email": comment.email,
                "body": comment.body
            ]
            jsonArray.append(dict)
        }
        return jsonArray
    }
}

// Modelo de comentario que corresponde al formato JSON
struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
