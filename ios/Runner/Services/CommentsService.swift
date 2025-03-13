import Foundation

class CommentsService {

    func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: data)
                completion(.success(comments))
            } catch {
                completion(.failure(NetworkError.jsonParsingError(error.localizedDescription)))
            }
        }
        
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case networkError(String)
    case noData
    case jsonParsingError(String)
}
