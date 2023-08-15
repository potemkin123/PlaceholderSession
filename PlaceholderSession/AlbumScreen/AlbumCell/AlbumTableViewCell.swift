//
//  AlbumTableViewCell.swift
//  PlaceholderSession
//
//  Created by Владислав Юрченко on 06.08.2023.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell {
    var onAlbumSelect: (() -> Void)?
    private var album: Album?
    @IBOutlet private weak var albumTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectAlbum))
            albumTitle.addGestureRecognizer(tapGestureRecognizer)
            albumTitle.isUserInteractionEnabled = true
    }
    
    static var identifier: String {
        return String(describing: AlbumTableViewCell.self)
    }
    
    static func register() -> UINib {
        UINib(nibName: String(describing: AlbumTableViewCell.self), bundle: nil)
    }
    
    @objc func didSelectAlbum() {
        onAlbumSelect?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(album: Album) {
        self.album = album
        albumTitle.text = album.title
    }
}
