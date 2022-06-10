//
//  ApiResponse.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let results: T?
    let error: String?
}
