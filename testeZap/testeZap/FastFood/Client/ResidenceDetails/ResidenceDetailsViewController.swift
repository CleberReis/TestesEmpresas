//
//  VivaRealViewController.swift
//  testeZap
//
//  Created by Cleber Reis on 23/02/21.
//

import UIKit
import MapKit

class ResidenceDetailsViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var lblNameHotel: UILabel!
    @IBOutlet weak var lblConvenience: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var residenceDetail: ResidenceModel?
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
        
    // MARK: - Methods
    
    private func setup() {
        self.lblNameHotel.text = residenceDetail?.address?.city ?? ""
        self.lblConvenience.text = "Banheiros: \(residenceDetail?.bathrooms ?? 0) | Quartos: \(residenceDetail?.bedrooms ?? 0)"
    }

}

extension ResidenceDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return residenceDetail?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
