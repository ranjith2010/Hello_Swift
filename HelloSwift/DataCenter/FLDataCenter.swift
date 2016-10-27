//
//  FLDataCenter.swift
//  HelloSwift
//
//  Created by Ranjith Kumar on 26/10/2016.
//  Copyright © 2016 Ranjith Kumar. All rights reserved.
//

import UIKit
import Alamofire

typealias returnBlock = (URLResponse, Any?, Error?) -> Void

class FLDataCenter: NSObject {
    
   private var baseURL: String? = nil
    
    class var sharedInstance: FLDataCenter {
        struct Static {
            static let instance: FLDataCenter = FLDataCenter()
        }
        return Static.instance
    }
    
    func setBaseDomain(domain:String) {
        self.baseURL = domain;
    }
    
 
    func GET(connectingURL:String,
             parameters:Dictionary<String,Any>,
             headers:Dictionary<String,String>,
             ReturnBlock:@escaping returnBlock) {
        
        if connectingURL.isEmpty {
            print("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return;
        }
        
        Alamofire.request(connectingURL, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                switch(response.result) {
                case .success(_):
                    let data = response.result.value
                    ReturnBlock(response.response!,data,nil)
                    break
                case .failure(_):
                    print(response.result.error)
                    ReturnBlock(response.response!, nil, response.result.error!)
                    break
                }
        }
    }
    
    func POST(connectingURL:String,
              parameters:Dictionary<String,Any>,
              headers:Dictionary<String,String>,
              ReturnBlock:@escaping returnBlock) {
        
        if connectingURL.isEmpty {
            print("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return;
        }
        
        Alamofire.request(connectingURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                switch(response.result) {
                case .success(_):
                    let data = response.result.value
                    ReturnBlock(response.response!,data,nil)
                    break
                case .failure(_):
                    print(response.result.error)
                    ReturnBlock(response.response!,nil,response.result.error!)
                    break
                    
                }
        }
    }
    
    func PUT(connectingURL:String,
             parameters:Dictionary<String,Any>,
             headers:Dictionary<String,String>,
             ReturnBlock:@escaping returnBlock) {
        
        let endURL = baseURL?.appending(connectingURL)
        if (endURL!.isEmpty) {
            print("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return;
        }
        
        Alamofire.request(endURL!, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                switch(response.result) {
                case .success(_):
                    let data = response.result.value
                    ReturnBlock(response.response!,data,nil)
                    break
                case .failure(_):
                    print(response.result.error)
                    ReturnBlock(response.response!,nil,response.result.error!)
                    break
                    
                }
        }
    }
    
    func DELETE(connectingURL:String,
                parameters:Dictionary<String,Any>,
                headers:Dictionary<String,String>,
                ReturnBlock:@escaping returnBlock) {
        
        let endURL = baseURL?.appending(connectingURL)
        if (endURL!.isEmpty) {
            print("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return;
        }
        
        Alamofire.request(connectingURL, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                switch(response.result) {
                case .success(_):
                    let data = response.result.value
                    ReturnBlock(response.response!,data,nil)
                    break
                case .failure(_):
                    print(response.result.error)
                    ReturnBlock(response.response!,nil,response.result.error!)
                    break
                    
                }
        }
    }
    
    func PATCH(connectingURL:String,
               parameters:Dictionary<String,Any>,
               headers:Dictionary<String,String>,
               ReturnBlock:@escaping returnBlock) {
        
        let endURL = baseURL?.appending(connectingURL)
        if (endURL!.isEmpty) {
            print("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return;
        }
        
        Alamofire.request(connectingURL, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON
            {
                response in
                switch(response.result) {
                case .success(_):
                    let data = response.result.value
                    ReturnBlock(response.response!,data,nil)
                    break
                case .failure(_):
                    print(response.result.error)
                    ReturnBlock(response.response!,nil,response.result.error!)
                    break
                    
                }
        }
    }
    
    func POST(connectingURL:String,
              image:UIImage,
              imageName:String,
              imageKey:String,
              mimeType:String,
              parameters:Dictionary<String,Any>,
              headers:Dictionary<String,String>,
              ReturnBlock:@escaping returnBlock) {
        
        var mimeType = mimeType
        var imageKey = imageKey
        var imageName = imageName
        
        let endURL = baseURL?.appending(connectingURL)
        if (endURL!.isEmpty) {
            print("Unable to connect to API.\nThe base url and the connecting url are empty. Use setDomain: method to set a base url or provide an endurl in this method call to connect to the API");
            return;
        }
        
        if (!imageKey.isEmpty) {
            imageKey = "image";
        }
        if (!imageName.isEmpty) {
            imageName = "image";
        }
        if !mimeType.isEmpty {
            mimeType = "image/jpeg";
        }
        
        
        Alamofire.upload(multipartFormData: {multipartData in
            
            // import image to request
            if let imageData = UIImageJPEGRepresentation(image, 1) {
                multipartData.append(imageData, withName: imageName, mimeType: mimeType)
            }
            
            // import parameters
            for (key, value) in parameters {
                multipartData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            
            }, to: endURL!, encodingCompletion: {encodingResult in   switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
                }
        })
        
    }
    
}