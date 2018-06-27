//
//  LogoApi.swift
//  iCatchUp
//
//  Created by Developer User on 5/22/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class LogoApi {
    static let baseUrl = "https://logo.clearbit.com/"
    
    public static func urlToLogo(forString string: String, withSize size: Int = 128) -> String {
        if let url = URL(string: string) {
            return "\(baseUrl)\(url.host!)?size=\(size)"
        }
        return "\(baseUrl)\(string)"
    }
}
