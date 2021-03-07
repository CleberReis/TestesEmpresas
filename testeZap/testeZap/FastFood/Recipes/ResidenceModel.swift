//
//  ResidenceModel.swift
//  testeZap
//
//  Created by Cleber Reis on 24/02/21.
//

import Foundation

struct ResidenceModel: Codable {
    let usableAreas: Int?
    let listingType: String?
    let createdAt: String?
    let listingStatus, id: String?
    let parkingSpaces: Int?
    let updatedAt: String?
    let owner: Bool?
    let images: [String]?
    let address: Address?
    let bathrooms, bedrooms: Int?
    let pricingInfos: PricingInfos?
}

// MARK: - Address
struct Address: Codable {
    let city: String?
    let neighborhood: String?
    let geoLocation: GeoLocation?
}

// MARK: - GeoLocation
struct GeoLocation: Codable {
    let precision: String?
    let location: Location?
}

// MARK: - Location
struct Location: Codable {
    let lon: Double?
    let lat: Double?
}

// MARK: - PricingInfos
struct PricingInfos: Codable {
    let yearlyIptu: String?
    let price: String?
    let businessType: String?
    let monthlyCondoFee: String?
    
    var businessTypeEnum: EnumBusiness {
        return EnumBusiness.getType(title: businessType)
    }
}

extension ResidenceModel {
    var isValidUsableAreas: Bool {
        if let usableAreas = usableAreas, usableAreas > 0 {
            return true
        } else {
            return false
        }
    }
    
    var isValidPriceForSale: Bool {
        if let price = pricingInfos?.price, price != "" {
            if let doublePrice = Double(price) {
                let priceToCompare = isValidBoundingBox ? 3150.0 : 3500.0
                if doublePrice > priceToCompare && isValidUsableAreas {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    var isValidCondoFee: Bool {
        if let condoFee = pricingInfos?.monthlyCondoFee, condoFee != "" {
            if let numberCondoFee = Double(condoFee) {
                
                if let stringPrice = pricingInfos?.price, let price = Double(stringPrice), price > 0 {
                    
                    let percentueToCompare = isValidBoundingBox ? 50.0 : 30.0
                    
                    let priceToCompare = (price * percentueToCompare) / 100
                    if numberCondoFee < priceToCompare {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    var isValidLocale: Bool {
        if address?.geoLocation?.location?.lon == 0.0 ||
            address?.geoLocation?.location?.lon == nil ||
            address?.geoLocation?.location?.lat == 0.0 ||
            address?.geoLocation?.location?.lat == nil {
            return false
        } else {
            return true
        }
    }
    
    var isValidBoundingBox: Bool {
        let minlon = -46.693419
        let minlat = -23.568704
        let maxlon = -46.641146
        let maxlat = -23.546686
        
        if isValidLocale {
            
            var validLon: Bool = false
            var validLat:Bool = false
            
            if address?.geoLocation?.location?.lon ?? 0.0 < maxlon &&
                address?.geoLocation?.location?.lon ?? 0.0 > minlon {
                validLon = true
            } else {
                validLon = false
            }
            
            if address?.geoLocation?.location?.lat ?? 0.0 < maxlat &&
                address?.geoLocation?.location?.lat ?? 0.0 > minlat {
                validLat = true
            } else {
                validLat = false
            }
            
            if validLat && validLon {
                return true
            } else {
                return false
            }
            
        } else {
            return false
        }
    
    }
}
