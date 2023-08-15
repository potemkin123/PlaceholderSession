import Foundation

final class AlbumViewModel {
    private var albumResult: (([Album]) -> Void)?
    private var albumIsLoading: ((Bool) -> Void)?
    private let userId: Int
   
    
    init(userId: Int) {
        self.userId = userId
    }
    
    func onRefresh(completion: @escaping (([Album]) -> Void)) {
        albumIsLoading?(true)
        var request = URLRequest(url: URL(string : "https://jsonplaceholder.typicode.com/users/\(userId)/albums")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode([Album].self, from: data)

                DispatchQueue.main.async {
                    self.albumResult?(result)
                    self.albumIsLoading?(false)
                    completion(result)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.albumIsLoading?(false)
                }
            }
        }
        task.resume()
    }
}
