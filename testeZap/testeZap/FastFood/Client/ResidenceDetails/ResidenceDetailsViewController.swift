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
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(UINib(nibName: cell, bundle: nil), forCellWithReuseIdentifier: cell)
        }
    }
    
    // MARK: - Properties
    var residenceDetail: ResidenceModel?
    private let cell = String(describing: GenericCollectionViewCell.self)
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods
    private func setup() {
        self.lblNameHotel.text = residenceDetail?.address?.city ?? ""
        self.lblConvenience.text = "Banheiros: \(residenceDetail?.bathrooms ?? 0) | Quartos: \(residenceDetail?.bedrooms ?? 0)"
        self.mapConfig()
    }
    
    private func mapConfig() {
        let latitude = residenceDetail?.address?.geoLocation?.location?.lat ?? 0.0
        let longitude = residenceDetail?.address?.geoLocation?.location?.lon ?? 0.0
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = residenceDetail?.address?.city
        annotation.subtitle = residenceDetail?.address?.neighborhood
        
        mapView.addAnnotation(annotation)
    }
    
}

extension ResidenceDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return residenceDetail?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath) as? GenericCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let item = self.residenceDetail?.images?[indexPath.item] {
            cell.setImage(image: item)
        }
        
        return cell
    }
    
}
