//
//  verifyOTPModel.swift
//  Texliv
//
//  Created by CSPrasad on 10/06/22.
//

import Foundation

struct verifyOTPModel: Decodable {
    let isLogin: Bool
    var user: userInfoModel
}

struct userInfoModel: Decodable {
    let avatar: String
    let firstName: String
    let lastName: String
    let email: String
    let rewards: Int
    let nextGoal: Int
    let referralMessage: String
}
