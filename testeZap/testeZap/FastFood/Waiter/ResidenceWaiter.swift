//
//  ZapWaiter.swift
//  testeZap
//
//  Created by Cleber Reis on 24/02/21.
//

import Foundation

internal class ResidenceWaiter {
    
    internal weak var orderReady: ResidenceOrderReady?
    private let kitchen = ResidenceKitchen()
    private var arrayResidences: [ResidenceModel]?
    
}

extension ResidenceWaiter: ResidenceOrder {
    
    func refreshResidenceForMe(type: EnumTypes) {
        self.arrayResidences = nil
        bringMeResidencesForMe(type: type)
    }

    func bringMeResidencesForMe(type: EnumTypes) {
        DispatchQueue.main.async {
            if let array = self.arrayResidences, !array.isEmpty {
                self.filterResidences(by: type)
            } else {
                self.kitchen.retrieveResidence { (result) in
                    switch result {
                        case .success(let response):
                            self.arrayResidences = response
                            self.filterResidences(by: type)
                        case .failure:
                            self.orderReady?.errorWithYourResidences()
                    }
                }
            }

        }
    }
    
    private func filterResidences(by type: EnumTypes) {
        DispatchQueue.main.async {
            guard let array = self.arrayResidences else {
                self.orderReady?.errorWithYourResidences()
                return
            }
            
            if array.isEmpty {
                self.orderReady?.residencesAreEmpty()
            } else {
                self.mapResidences(by: type, array: array)
            }
        }
    }
    
    private func mapResidences(by type: EnumTypes, array: [ResidenceModel]) {
        DispatchQueue.main.async {
            switch type {
                case .vivaReal:
                    let residencesVivaReal = array.filter({
                        $0.pricingInfos?.businessTypeEnum == .rental &&
                        $0.isValidLocale == true &&
                        $0.isValidCondoFee == true
                    })
                    self.orderReady?.hereAreYourResidences(residences: residencesVivaReal)
                case .zap:
                    let residenceZap = array.filter({
                        $0.pricingInfos?.businessTypeEnum == .sale &&
                        $0.isValidLocale == true &&
                        $0.isValidUsableAreas == true &&
                        $0.isValidPriceForSale == true
                    })
                    self.orderReady?.hereAreYourResidences(residences: residenceZap)
                default:
                    self.orderReady?.residencesAreEmpty()
            }
        }
    }
    
}
