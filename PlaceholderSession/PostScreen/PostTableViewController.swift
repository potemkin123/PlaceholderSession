import UIKit

final class PostTableViewController: UITableViewController {
    private var postModel: PostsViewModel!
    var userId: Int?
    private var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userId else { return }
        postModel = PostsViewModel(userId: userId)
        title = "POSTS".localized
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.register(UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        postModel.onRefresh() { [weak self] result in
            self?.posts = result
            self?.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.identifier)) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.setup(post: post)
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}
