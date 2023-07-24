import UIKit

protocol UserTableViewCellDelegate: AnyObject {
}

final class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nickNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var companyLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var nickNameInfo: UILabel!
    @IBOutlet private weak var emailInfo: UILabel!
    @IBOutlet private weak var phoneInfo: UILabel!
    @IBOutlet private weak var websiteInfo: UILabel!
    @IBOutlet private weak var companyInfo: UILabel!
    @IBOutlet private weak var addressInfo: UILabel!
    @IBOutlet weak var postsButton: UIButton!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    public static var identifier: String {
        get {
            return String(describing: UserTableViewCell.self)        }
    }
    public static func register() -> UINib {
        UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(user: User) {
        let address = """
               Address: \(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)
               """
        nameLabel.text = user.name
        nickNameInfo.text = user.username
        emailInfo.text = user.email
        phoneInfo.text = user.phone
        websiteInfo.text = user.website
        companyInfo.text = user.company.name
        addressInfo.text = address
        nickNameLabel.text = "Username"
        emailLabel.text = "Email"
        phoneLabel.text = "Phone"
        websiteLabel.text = "Website"
        companyLabel.text = "Company"
        addressLabel.text = "Address"
        postsButton.setTitle("Posts", for: .normal)
        photosButton.setTitle("Photos", for: .normal)
        albumButton.setTitle("Album", for: .normal)
    }
}
