//
//  API.swift
//  Tiki
//
//  Created by Mac on 4/19/19.
//  Copyright © 2019 Truong Hoang Minh. All rights reserved.
//

import ObjectMapper
import AlamofireObjectMapper
import Alamofire
import SystemConfiguration


class API: UIResponder {
    //1
    class var sharedInstance: API {
        //2
        struct Singleton {
            //3
            static let instance = API()
        }
        //4
        return Singleton.instance
    }
    
    override init() {
        super.init()
    }
    
    func checkInternet() -> Bool {
        
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
    
    //MARK: -- callServicePostMethod
    func callServiceWithPOSTMethod(params : Dictionary<String, AnyObject>, url : String, deleteMethod: Bool, putMethod: Bool, isRefresh : Bool? = false, postCompleted : @escaping (_ data: AnyObject?, _ statusCode: Int?) -> ()) {
        Alamofire.request(url, method:  deleteMethod == true ? .delete : (putMethod == true ? .put : .post), parameters: params,  encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response.result)
                return postCompleted(response.result.value as AnyObject?, response.response?.statusCode)
            case .failure( _):
                return postCompleted(nil, response.response?.statusCode)
            }
        }
        
    }
    
    func checkOnlineCallServiceWithMethod(isRefresh: Bool? = false, params : NSDictionary?, files: NSDictionary? = nil, url : String, postMethod : Bool, deleteMethod : Bool? = false, putMethod : Bool? = false, upload: Bool? = false, postCompleted : @escaping (_ data: AnyObject?) -> ()) {
        var parseParams : Dictionary<String, AnyObject>? = params as? Dictionary<String, AnyObject>
        if(parseParams == nil){
            parseParams = Dictionary<String, AnyObject>()
        }
        
        if self.checkInternet() {
            if(postMethod) {
                if upload! {
                    var fileParams : Dictionary<String, AnyObject>? = files as? Dictionary<String, AnyObject>
                    if(fileParams == nil){
                        fileParams = Dictionary<String, AnyObject>()
                    }
                    self.callServiceWithUploadMethod(params: parseParams!, files: fileParams!, url: url, postCompleted: { (data, statusCode) -> () in
                        if(statusCode == 200) {// code successs
                            if(data != nil) {
                                return postCompleted(data)
                            }else{
                                return postCompleted(nil)
                            }
                        } else {
                            return postCompleted(nil)
                        }
                    })
                }else{
                    self.callServiceWithPOSTMethod(params: parseParams!, url: url, deleteMethod: deleteMethod!, putMethod: putMethod!, isRefresh: isRefresh, postCompleted: { (data, statusCode) -> () in
                        if(statusCode == 200) {// code successs
                            if(data != nil) {
                                return postCompleted(data)
                            } else {
                                return postCompleted(nil)
                            }
                        } else {
                            return postCompleted(nil)
                        }
                    })
                }
            }else{
                self.callServiceWithGETMethod(params: parseParams!, url: url, deleteMethod: deleteMethod!,putMethod: putMethod!, postCompleted: { (data, statusCode) -> () in
                    if(statusCode == 200){// code successs
                        if(data != nil) {
                            return postCompleted(data)
                        } else {
                            return postCompleted(nil)
                        }
                    } else {
                        return postCompleted(nil)
                    }
                })
            }
        }else{
            return postCompleted(nil)
        }
    }
    
    //MARK: GET METHOD CALL API
    func callServiceWithGETMethod(params : Dictionary<String, AnyObject>, url : String, deleteMethod : Bool, putMethod : Bool, postCompleted : @escaping (_ data:AnyObject?, _ statusCode: Int?) -> ()){
        Alamofire.request(url, method:.get, parameters: params, encoding: URLEncoding.default, headers: [:]).responseJSON { response in
            debugPrint("Request  \(String(describing: response.request))")
            debugPrint("RESPONSE \(String(describing: response.result.value))")
            debugPrint(response.result)
            switch response.result {
            case .success:
                return postCompleted(response.result.value as AnyObject?, response.response?.statusCode)
            case .failure( _):
                return postCompleted(nil, response.response?.statusCode)
            }
        }
        
    }
    
    func callServiceWithUploadMethod(params: Dictionary<String, AnyObject>, files: Dictionary<String, AnyObject>, url : String, postCompleted : @escaping (_ data: AnyObject?, _ statusCode: Int?) -> ()) {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for param in params {
                    let data = String(describing: param.value).data(using: .utf8)!
                    multipartFormData.append(data, withName: param.key)
                }
                for file in files {
                    multipartFormData.append(file.value as! Data, withName: file.key, fileName: file.key + ".png",mimeType: "image/png")
                }
        }, to: url, headers: [:],
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    return postCompleted(response.result.value as AnyObject?, response.response?.statusCode)
                }
            case .failure( _):
                return postCompleted(nil, 500)
            }
        })
    }
    
    //MARK: - List Hot Items
    
    func getHotItems(callBack:@escaping (_ data:AnyObject?)->Void) ->Void {
        let url: String  = LinkAPI.apiHotItems.rawValue
        let params: [String: Any] = [:]
        
        checkOnlineCallServiceWithMethod(params: params as NSDictionary? , url: url, postMethod : false) { (data) -> () in
            return callBack(data)
        }
    }
}
