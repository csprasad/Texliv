//
//  Route.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://hiring.getbasis.co/candidate"
    
    case fetchToken
    case otpValidate
    
    var description: String {
        switch self {
        case .fetchToken:
            return "/users/email"
        case .otpValidate:
            return "/users/email"
        }
    }
}
