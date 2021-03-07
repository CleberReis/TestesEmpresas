//
//  GenericTableViewCell.swift
//  testeZap
//
//  Created by Cleber Reis on 24/02/21.
//

import UIKit

class GenericTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var imgHotel: CustomImageView!
    @IBOutlet weak var lblNameHotel: UILabel!
    @IBOutlet weak var lblPriceHotel: UILabel!
    @IBOutlet weak var lblConvenience: UILabel!
    @IBOutlet weak var viewNames: UIView! {
        didSet {
            self.viewNames.layer.cornerRadius = 8
            self.viewNames.layer.borderWidth = 0.5
            self.viewNames.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    // MARK: - SuperMethods
    override func prepareForReuse() {
        super.prepareForReuse()
        imgHotel.image = UIImage(named: "hotel")
        lblNameHotel.text = "Carregando..."
        lblConvenience.text = "Carregando..."
        lblPriceHotel.text = "Carregando..."
    }
    
    // MARK: - Methods
    internal func setupCell(residenceModel: ResidenceModel) {
        if let image = residenceModel.images?[0] {
            DispatchQueue.main.async {
                self.imgHotel.downloadImageFrom(urlString: image, imageMode: .scaleAspectFill)
            }
        }
        
        lblNameHotel.text = residenceModel.address?.city ?? ""
        lblConvenience.text = "Banheiros: \(residenceModel.bathrooms ?? 0) | Quartos: \(residenceModel.bedrooms ?? 0)"
        lblPriceHotel.text = residenceModel.pricingInfos?.price ?? "Indisponível"
        
    }

}
