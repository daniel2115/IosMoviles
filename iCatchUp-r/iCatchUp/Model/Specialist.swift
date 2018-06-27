import Foundation
import SwiftyJSON

class Specialist {
    var id: Int
    var login: String
    var password: String
    var name: String
    var lastName: String
    var email: String
    var companyName: String
    var serviceDescription: String
    var documentTypeId: Int
    var documentNumber: String
    var phoneNumber: String
    var facebook: String
    var webSite: String
    var address: String
    var reference: String
    var latitude: Double
    var longitude: Double
    var acredited: Bool
    var membership: Bool
    var rate: Double
    var online: Bool
    var state: Bool
    
    init(id: Int, login: String, password: String, name: String, lastName: String,
         email: String, companyName: String, serviceDescription: String,
         documentTypeId: Int, documentNumber: String, phoneNumber: String,
         facebook: String, webSite: String, address: String, reference: String,
         latitude: Double, longitude: Double, acredited: Bool, membership: Bool,
         rate: Double, online: Bool, state: Bool) {
        self.id = id
        self.login = login
        self.password = password
        self.name = name
        self.lastName = lastName
        self.email = email
        self.companyName = companyName
        self.serviceDescription = serviceDescription
        self.documentTypeId = documentTypeId
        self.documentNumber = documentNumber
        self.phoneNumber = phoneNumber
        self.facebook = facebook
        self.webSite = webSite
        self.address = address
        self.reference = reference
        self.latitude = latitude
        self.longitude = longitude
        self.acredited = acredited
        self.membership = membership
        self.rate = rate
        self.online = online
        self.state = state
    }
    
    convenience init(from jsonSource: JSON) {
        self.init(id: jsonSource["id"].intValue,
                  login: jsonSource["login"].stringValue,
                  password: jsonSource["password"].stringValue,
                  name: jsonSource["name"].stringValue,
                  lastName: jsonSource["lastName"].stringValue,
                  email: jsonSource["email"].stringValue,
                  companyName: jsonSource["companyName"].stringValue,
                  serviceDescription: jsonSource["serviceDescription"].stringValue,
                  documentTypeId: jsonSource["documentTypeId"].intValue,
                  documentNumber: jsonSource["documentNumber"].stringValue,
                  phoneNumber: jsonSource["phoneNumber"].stringValue,
                  facebook: jsonSource["facebook"].stringValue,
                  webSite: jsonSource["webSite"].stringValue,
                  address: jsonSource["address"].stringValue,
                  reference: jsonSource["reference"].stringValue,
                  latitude:jsonSource["latitude"].doubleValue,
                  longitude: jsonSource["longitude"].doubleValue,
                  acredited: jsonSource["acredited"].boolValue,
                  membership: jsonSource["membership"].boolValue,
                  rate: jsonSource["rate"].doubleValue,
                  online: jsonSource["online"].boolValue,
                  state: jsonSource["state"].boolValue)
    }
    
    class func buildAll(from jsonSpecialists: [JSON]) -> [Specialist]{
        let count = jsonSpecialists.count
        var specialists: [Specialist] = []
        for i in 0 ..< count {
            specialists.append(Specialist(from: JSON(jsonSpecialists[i])))
        }
        return specialists
    }
    
    class func build(from jsonSpecialists: JSON) -> Specialist{
        var specialists: Specialist
        specialists = Specialist(from: JSON(jsonSpecialists))
        return specialists
    }
}
        

