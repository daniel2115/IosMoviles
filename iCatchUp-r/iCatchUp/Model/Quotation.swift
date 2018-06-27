import Foundation
import SwiftyJSON

class Quotation {
    
    var id: Int
    var problemId: Int
    var specialistId:Int
    var description: String
    var price:Double
    var estimatedTime: Int
    var includesMaterial: Bool
    var state: Bool
    var startDate: String
    var finishDate: String
    var finalPrice: Double
    var specialistRate: Int
    var specialistComment: String
    var customerRate: Int
    var customerComment: String
    
    init(id: Int, problemId: Int, specialistId: Int, description: String,
         price: Double, estimatedTime: Int, includesMaterial: Bool,state: Bool,
         startDate: String,finishDate: String,finalPrice: Double,specialistRate: Int,
         specialistComment: String,customerRate: Int,customerComment: String) {
      
        self.id = id
        self.problemId = problemId
        self.specialistId = specialistId
        self.description = description
        self.price = price
        self.estimatedTime = estimatedTime
        self.includesMaterial = includesMaterial
        self.state = state
        self.startDate = startDate
        self.finishDate = finishDate
        self.finalPrice = finalPrice
        self.specialistRate = specialistRate
        self.specialistComment = specialistComment
        self.customerRate = customerRate
        self.customerComment = customerComment
    }
    
    /*
    convenience init(id: String, problemId: String, specialistId: String,price: String, estimatedTime: String,startDate: String,finishDate: String,finalPrice: String,specialistRate: String,customerRate: String) {
        
        self.init(id: id, problemId: problemId, specialistId: specialistId, description: "", price: price,
                  estimatedTime: estimatedTime, includesMaterial: "", state: "", startDate: startDate,
                  finishDate: finishDate, finalPrice: finalPrice, specialistRate: specialistRate, specialistComment:"",
                  customerRate:customerRate , customerComment: "")
        
    }*/
    
    convenience init(from jsonSource: JSON) {
        self.init(id: jsonSource["id"].intValue,
                  problemId: jsonSource["problemId"].intValue,
                  specialistId: jsonSource["specialistId"].intValue,
                  description: jsonSource["description"].stringValue,
                  price: jsonSource["price"].doubleValue,
                  estimatedTime: jsonSource["estimatedTime"].intValue,
                  includesMaterial: jsonSource["includesMaterial"].boolValue,
                  state: jsonSource["state"].boolValue,
                  startDate: jsonSource["startDate"].stringValue,
                  finishDate: jsonSource["finishDate"].stringValue,
                  finalPrice: jsonSource["finalPrice"].doubleValue,
                  specialistRate: jsonSource["specialistRate"].intValue,
                  specialistComment: jsonSource["specialistComment"].stringValue,
                  customerRate: jsonSource["customerRate"].intValue,
                  customerComment: jsonSource["customerComment"].stringValue)
    }
    
    class func buildAll(from jsonQuotations: [JSON]) -> [Quotation]{
        let count = jsonQuotations.count
        var quotations: [Quotation] = []
        for i in 0 ..< count {
            quotations.append(Quotation(from: JSON(jsonQuotations[i])))
        }
        return quotations
    }
    
}






