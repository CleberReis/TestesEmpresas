//
//  CustomImageView.swift
//  testeZap
//
//  Created by Cleber Reis on 07/03/21.
//

import UIKit

class CustomImageView: UIImageView {
    
    // MARK: - Constants
    let imageCache = NSCache<NSString, AnyObject>()
        
    // MARK: - Methods
    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }
    
    private func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cacheImage
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                        self.image = imageToCache
                    } else {
                        self.image = UIImage(named: "hotel")
                    }
                }
            }.resume()
        }
    }
}
