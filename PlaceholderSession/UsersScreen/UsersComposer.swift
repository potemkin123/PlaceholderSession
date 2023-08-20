import UIKit

final class UsersComposer {
    private init() {}
    
    static func build() -> UIViewController {
        let viewModel = UsersViewModel()
        let controller = UsersViewController(viewModel: viewModel)
        return controller
    }
}
