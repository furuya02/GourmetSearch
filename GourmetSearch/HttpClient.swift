//Alamofireをラップするだけのクラス
//このクラスをモックに置き換えることで、サーバに依存しないテストが可能になる

import Foundation
import Alamofire
import SwiftyJSON

public class HttpClient{
    public func request(
        method: Alamofire.Method,
        URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL
        ) -> Request {
            return Alamofire.request(method, URLString, parameters: parameters , encoding: encoding)
    }
    
    public func response(request:Request,completionHandler: (
            NSURLRequest,
            NSHTTPURLResponse?,
            AnyObject?,
            NSError?) -> Void ) -> Request{
        
        return request.response(completionHandler)
    }
    
    public func serializer(data: AnyObject? , error: NSError?) -> JSON {
        var json = JSON.nullJSON
        if(error == nil && data != nil && data is NSData){
            json = SwiftyJSON.JSON(data: data as! NSData)
        }
        return json
    }
}