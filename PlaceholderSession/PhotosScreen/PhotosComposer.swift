//
//  PhotosComposer.swift
//  PlaceholderSession
//
//  Created by Владислав Юрченко on 17.08.2023.
//

import UIKit
final class PhotosComposer {
    private init() {}
    
    static func build(albumId: Int) -> UIViewController {
        let viewModel = PhotoViewModel(albumId: albumId)
        let controller = PhotosViewController(viewModel: viewModel)
        return controller
    }
}
