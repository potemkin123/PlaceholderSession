import UIKit

final class AlbumTableViewController: UITableViewController {
    private var albumModel: AlbumViewModelProtocol
    private var album: [Album] = []
    
    init(viewModel: AlbumViewModelProtocol) {
        self.albumModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ALBUM".localized
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 40.0
        tableView.reloadData()
        tableView.register(UINib(nibName: String(describing: AlbumTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AlbumTableViewCell.self))
        albumModel.onRefresh() { [weak self] result in
            self?.album = result
            self?.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AlbumTableViewCell.identifier)) as! AlbumTableViewCell
        let album = album[indexPath.row]
        cell.setup(album: album)
        cell.onAlbumSelect = { [weak self] in
            guard let self else { return }
            let controller = PhotosComposer.build(albumId: album.id)
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
}
