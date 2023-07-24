import Foundation

protocol UserView: AnyObject {
    func display(_ userResult: [User])
    func display(isLoading: Bool)
}

final class UsersPresenter {

    weak var view: UserView?

    func onRefresh() {
        view?.display(isLoading: true)
        var request = URLRequest(url: URL(string : "https://jsonplaceholder.typicode.com/users")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode([User].self, from: data)

                DispatchQueue.main.async {
                    self.view?.display(result)
                    self.view?.display(isLoading: false)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        task.resume()
    }
}
