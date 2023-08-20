import UIKit

final class PostsComposer {
    private init() {}
    
    static func build(userId: Int) -> UIViewController {
        let viewModel = PostsViewModel(userId: userId)
        let controller = PostTableViewController(viewModel: viewModel)
        return controller
    }
}
