import Foundation

protocol UsersViewModelProtocol {
    var userResult: (([User]) -> Void)? { get set }
    var userIsLoading: ((Bool) -> Void)? { get set }
    func onRefresh()
    func onSearchText(_ text: String)
}

final class UsersViewModel: UsersViewModelProtocol {
    var userResult: (([User]) -> Void)?
    var userIsLoading: ((Bool) -> Void)?
    private var displayUsers = [User]()
    private var allUsers = [User]()
    
    func onRefresh() {
        userIsLoading?(true)
        var request = URLRequest(url: URL(string : "https://jsonplaceholder.typicode.com/users")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([User].self, from: data)
                self.allUsers = result
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
    
    func onSearchText( _ text: String) {
        if text.isEmpty {
            displayUsers = allUsers
        } else {
            displayUsers = allUsers.filter { $0.username.contains(text) || $0.email.contains(text) }
        }
        self.userResult?(displayUsers)
    }
}
