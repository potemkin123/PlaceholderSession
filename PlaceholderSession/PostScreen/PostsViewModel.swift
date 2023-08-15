import Foundation

final class PostsViewModel {
    private var postResult: (([Post]) -> Void)?
    private var postIsLoading: ((Bool) -> Void)?
    private let userId: Int
    
    init(userId: Int) {
        self.userId = userId
    }

    func onRefresh(completion: @escaping (([Post]) -> Void)) {
        postIsLoading?(true)
        var request = URLRequest(url: URL(string : "https://jsonplaceholder.typicode.com/users/\(userId)/posts")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode([Post].self, from: data)

                DispatchQueue.main.async {
                    self.postResult?(result)
                    self.postIsLoading?(false)
                    completion(result)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.postIsLoading?(false)
                }
            }
        }
        task.resume()
    }
}
