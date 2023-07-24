import UIKit

final class UsersViewController: UITableViewController {
    let userView = UsersPresenter()
    @IBOutlet private weak var userScreenView: UITableView!
    var models = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        userView.view = self
        self.navigationItem.title = "Users"
        tableView.refreshControl = UIRefreshControl()
        tableView?.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.register(UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        onRefresh()
    }
    
    @objc
    func onRefresh() {
        userView.onRefresh()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.identifier)) as! UserTableViewCell
        let user = models[indexPath.row]
        cell.setup(user: user)
        return cell
    }
}

extension UsersViewController: UserView {
    func display(_ userResult: [User]) {
        models = userResult
        tableView.reloadData()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            tableView.refreshControl?.beginRefreshing()
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }
}
