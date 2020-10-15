
import UIKit
import SystemConfiguration

open class Reachability {
   
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

struct connectionInfo
{                                       
    static let SERVER_URL =  "https://api.dev.datadrivencare.net/hubs/"
    
    static let HTTP_HEADER_ENCODING = "application/json; charset=utf-8"
    static let HTTP_CONTENT_TYPE = "Content-Type"
    static let HTTP_CONTENT_LENGTH = "Content-Length"
    static let HTTP_METHOD = "POST"
    static let HTTP_METHOD_GET = "GET"
}

struct apiMethod {
    
    static let hubInstallation = "/installation"
    static let hubAddSensor = "hubs/C44F33354375/sensors"
    
  
}



