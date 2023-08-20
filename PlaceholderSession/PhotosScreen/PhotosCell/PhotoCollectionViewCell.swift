import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titlePhoto: UILabel!
    @IBOutlet private weak var photoInAlbum: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var identifier: String {
        return String(describing: PhotoCollectionViewCell.self)
    }
    
    static func register() -> UINib {
        UINib(nibName: String(describing: PhotoCollectionViewCell.self), bundle: nil)
    }
    
    func setup(photo: Photo) {
        titlePhoto.text = photo.title
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: photo.url) {
                    DispatchQueue.main.async {
                        self.photoInAlbum.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
