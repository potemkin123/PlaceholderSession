import UIKit

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
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var albumButton: UIButton!
    var onPostsTap: (() -> Void)?
    var onAlbumTap: (() -> Void)?
    
    static var identifier: String {
            return String(describing: UserTableViewCell.self)
    }
    
    static func register() -> UINib {
        UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil)
    }
    
    @IBAction func postButtonTap(_ sender: Any) {
        onPostsTap?()
    }
    
    @IBAction func albumButtonTap(_ sender: Any) {
        onAlbumTap?()
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
        nickNameLabel.text = "USERNAME".localized
        emailLabel.text = "EMAIL".localized
        phoneLabel.text = "PHONE".localized
        websiteLabel.text = "WEBSITE".localized
        companyLabel.text = "COMPANY".localized
        addressLabel.text = "ADDRESS".localized
        postButton.setTitle("POSTS".localized, for: .normal)
        albumButton.setTitle("ALBUM".localized, for: .normal)
    }
}
