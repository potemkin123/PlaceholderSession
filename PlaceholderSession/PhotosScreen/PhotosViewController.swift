//
//  PhotosViewController.swift
//  PlaceholderSession
//
//  Created by Владислав Юрченко on 12.08.2023.
//

import UIKit

final class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var photoModel: PhotoViewModelProtocol
    private var photos: [Photo] = []
    
    init(viewModel: PhotoViewModelProtocol) {
        self.photoModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        title = "PHOTO".localized
        super.viewDidLoad()
        photoCollectionView.register(UINib(nibName: String(describing: PhotoCollectionViewCell.identifier), bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoModel.onRefresh() { [weak self] result in
            self?.photos = result
            self?.photoCollectionView.reloadData()
        }
    }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return photos.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.identifier), for: indexPath) as! PhotoCollectionViewCell
            let photo = photos[indexPath.row]
            cell.setup(photo: photo)
            return cell
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (UIScreen.main.bounds.width - 48) / 2
             let heigth = width / 200.0 * 200.0
            return CGSize(width: width, height: heigth)
    }
}
