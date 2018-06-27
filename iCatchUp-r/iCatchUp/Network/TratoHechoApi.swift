//
//  TratoHechoApi.swift
//  iCatchUp
//
//  Created by Alumnos on 6/25/18.
//  Copyright © 2018 ACME. All rights reserved.
//

import Foundation

class TratoHechoApi {
    
    static let AuthenticacionUrl = "http://movilesupc.somee.com/api/specialists/authentications"
    static let QuotationsUrl = "http://movilesupc.somee.com/api/specialists/1/quotations"
    
    public static var GetQuotations: String {
        return "\(QuotationsUrl)"
    }
    
    public static var GetAuthentication: String{
        return "\(AuthenticacionUrl)"
    }
    
}
