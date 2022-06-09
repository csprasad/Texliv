//
//  ApiResponse.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
