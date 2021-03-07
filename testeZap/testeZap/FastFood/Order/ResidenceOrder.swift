//
//  ZapOrder.swift
//  testeZap
//
//  Created by Cleber Reis on 24/02/21.
//

import Foundation

protocol ResidenceOrder {
    func bringMeResidencesForMe(type: EnumTypes)
    func refreshResidenceForMe(type: EnumTypes)
}

protocol ResidenceOrderReady: class {
    func hereAreYourResidences(residences: [ResidenceModel])
    func errorWithYourResidences()
    func residencesAreEmpty()
}
