//
//  GenericCollectionViewCell.swift
//  testeZap
//
//  Created by Cleber Reis on 07/03/21.
//

import UIKit

class GenericCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgHotel: CustomImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setImage(image: String) {
        self.imgHotel.downloadImageFrom(urlString: image, imageMode: .scaleAspectFill)
    }

}
