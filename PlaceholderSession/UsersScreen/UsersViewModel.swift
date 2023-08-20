import Foundation

protocol UsersViewModelProtocol {
    var userResult: (([User]) -> Void)? { get set }
    var userIsLoading: ((Bool) -> Void)? { get set }
    func onRefresh()
}

final class UsersViewModel: UsersViewModelProtocol {
    var userResult: (([User]) -> Void)?
    var userIsLoading: ((Bool) -> Void)?
    
    func onRefresh() {
        userIsLoading?(true)
        var request = URLRequest(url: URL(string : "https://jsonplaceholder.typicode.com/users")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode([User].self, from: data)
                
                DispatchQueue.main.async {
                    self.userResult?(result)
                    self.userIsLoading?(false)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.userIsLoading?(false)
                }
            }
        }
        task.resume()
    }
}
