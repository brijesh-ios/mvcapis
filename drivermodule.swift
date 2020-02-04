import Foundation
class DriverList: NSObject {
    
    
    var Name : String!
    var DriverNumber : String!
    var VehicleNumber : String!
    var VehicleId : String!
    var DLNo : String!
    
 
    public override init() {
        super.init()
    }
    
    public init(rawData: [String: Any]){
        
        super.init()
        
        if let value = rawData["Name"] as? String{
            self.Name = value
            
            
        }
        if let value = rawData["DriverNumber"] as? String{
            self.DriverNumber = value
            
        }
        
        if let value = rawData["VehicleNumber"] as? String{
            self.VehicleNumber = value
 
        }
        if let value = rawData["VehicleId"] as? String{
            self.VehicleId = value
            
        }
        
        if let value = rawData["DLNo"] as? String{
            self.DLNo = value
            
            
        }
        
        
        
    }
    
}





