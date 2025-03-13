import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    let commentsService = CommentsService()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "comments_channel", binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "getComments" {
                guard let args = call.arguments as? [String: Any], let postId = args["postId"] as? Int else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid postId", details: nil))
                    return
                }
                
                self.fetchComments(postId: postId, result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func fetchComments(postId: Int, result: @escaping FlutterResult) {
        commentsService.fetchComments(postId: postId) { response in
            switch response {
            case .success(let comments):
                let commentsJson = JSONConverter.convertCommentsToJson(comments)
                result(commentsJson)
                
            case .failure(let error):
                result(self.handleError(error))
            }
        }
    }

    private func handleError(_ error: Error) -> FlutterError {
        switch error {
        case let error as NetworkError:
            switch error {
            case .invalidURL:
                return FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil)
            case .networkError(let message):
                return FlutterError(code: "NETWORK_ERROR", message: message, details: nil)
            case .noData:
                return FlutterError(code: "NO_DATA", message: "No data received", details: nil)
            case .jsonParsingError(let message):
                return FlutterError(code: "JSON_ERROR", message: "Failed to decode JSON", details: message)
            }
        default:
            return FlutterError(code: "UNKNOWN_ERROR", message: "An unknown error occurred", details: nil)
        }
    }
}
