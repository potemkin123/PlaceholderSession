//
//  PostTableViewCell.swift
//  PlaceholderSession
//
//  Created by Владислав Юрченко on 06.08.2023.
//

import Foundation

final class PhotoViewModel {
    var photoResult: (([Photo]) -> Void)?
    var photoIsLoading: ((Bool) -> Void)?
    
    private let albumId: Int
   
    
    init(albumId: Int) {
        self.albumId = albumId
    }
    
    func onRefresh(completion: @escaping (([Photo]) -> Void)) {
        photoIsLoading?(true)
        var request = URLRequest(url: URL(string : "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode([Photo].self, from: data)

                DispatchQueue.main.async {
                    self.photoResult?(result)
                    self.photoIsLoading?(false)
                    completion(result)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    self.photoIsLoading?(false)
                }
            }
        }
        task.resume()
    }
}
