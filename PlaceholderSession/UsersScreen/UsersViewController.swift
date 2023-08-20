import UIKit

final class UsersViewController: UITableViewController {
    private var viewModel: UsersViewModelProtocol
    private var models = [User]()
    private var post = [Post]()
    
    init(viewModel: UsersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "USERS".localized
        tableView.refreshControl = UIRefreshControl()
        tableView?.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.register(UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        bindUserView()
        onRefresh()
    }
    
    func bindUserView() {
        viewModel.userResult = { [weak self] users in
            DispatchQueue.main.async {
                self?.models = users
                self?.tableView.reloadData()
            }
        }
        
        viewModel.userIsLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.tableView.refreshControl?.beginRefreshing()
                } else {
                    self?.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    @objc
    func onRefresh() {
        viewModel.onRefresh()
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
        cell.onPostsTap = { [weak self] in
            guard let self else { return }
            let controller = PostsComposer.build(userId: user.id)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        cell.onAlbumTap = { [weak self] in
            guard let self else { return }
            let controller = AlbumComposer.build(userId: user.id)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
}
