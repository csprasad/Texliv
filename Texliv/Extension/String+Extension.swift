//
//  String+Extension.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
