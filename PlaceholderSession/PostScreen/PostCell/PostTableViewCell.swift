import UIKit

final class PostTableViewCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var body: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static var identifier: String {
            return String(describing: PostTableViewCell.self)
    }
    
    static func register() -> UINib {
        UINib(nibName: String(describing: PostTableViewCell.self), bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
        title.text = "TITLE:".localized
        body.text = "BODY:".localized
    }
}
