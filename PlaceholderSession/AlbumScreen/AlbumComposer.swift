import UIKit

final class AlbumComposer {
    private init() {}
    
    static func build(userId: Int) -> UIViewController {
        let viewModel = AlbumViewModel(userId: userId)
        let controller = AlbumTableViewController(viewModel: viewModel)
        return controller
    }
}
