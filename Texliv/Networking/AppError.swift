//
//  AppError.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Oops!! Response could not be decoded"
        case .unknownError:
            return "OhhNooo!! We are unable to find error, Please give us a moment to check!"
        case .invalidUrl:
            return "HEYYY!!! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
