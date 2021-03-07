//
//  EnumBusiness.swift
//  testeZap
//
//  Created by Cleber Reis on 07/03/21.
//

import Foundation

enum EnumBusiness {
    case sale
    case rental
    case undefined
}

extension EnumBusiness {
    static func getType(title: String?) -> EnumBusiness {
        guard let title = title else { return .undefined }
        switch title {
            case "SALE":
                return .sale
            case "RENTAL":
                return .rental
            default:
                return .undefined
        }
    }
}
