//
//  EnumTypes.swift
//  testeZap
//
//  Created by Cleber Reis on 05/03/21.
//

import Foundation

enum EnumTypes {
    case zap
    case vivaReal
    case undefined
}

extension EnumTypes {
    static func getType(tag: Int) -> EnumTypes {
        switch tag {
            case 0:
                return .vivaReal
            case 1:
                return .zap
            default:
                return .undefined
        }
    }
}
