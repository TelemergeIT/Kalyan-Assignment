//
//  NetworkManager.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    private var jsonStrings:String?
    
    func executeServiceWithURL(urlString:String,postParameters:[String:Any]?,callback:@escaping (_ json:NSDictionary?,_ taskError:NSError?)->Void) {
        
        print("URL -: \(urlString)")
        
        if !Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.hide()
            appSharedData.showAlertControllerWith(title: projectName, andMessage: "The Internet connection appears to be offline.")
            return
        }
        do {
            
            if let _ = postParameters {
                
                print("Parameters -: \(postParameters!)")
                let json = try JSONSerialization.data(withJSONObject: postParameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
                jsonStrings  = String(data: json,encoding: String.Encoding.utf8)!
            }
            
            
        } catch let error as NSError {
            print("Error : - \(error.localizedDescription)")
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["Content-Type":"application/json"]
        
        let session = URLSession(configuration: sessionConfiguration)
        let mainURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = NSURL(string: mainURL!)
        
        let request = NSMutableURLRequest(url: url! as URL)
        
//        if urlString != WEB_URL.register && urlString != WEB_URL.login && urlString != WEB_URL.verifyOTP   {
//            if let token = coreDataManager.fetchUserDetail()?.token {
//                print("Token \(token)")
//                request.setValue(token, forHTTPHeaderField: "token")
//            }
//        }
        
        request.httpMethod = "GET"
        
        if let _ = postParameters {
            request.httpBody = jsonStrings?.data(using: String.Encoding.utf8)
            request.httpMethod = "POST"
        }
        
        let dataTask = session.dataTask(with: request as URLRequest) { (taskData, taskResponse, taskError) in
            
            DispatchQueue.main.async {
                
                do {
                    
                    if let taskD = taskData {
                        
                        if let json = try JSONSerialization.jsonObject(with:
                            taskD, options:.mutableLeaves) as? NSDictionary {
                            
                            print("JSON :- \(json)")
                            if let code: Int = json["status"] as? Int,code == 401 {
//                                coreDataManager.clearDataBase()
//                                let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginNavigationController") as! UINavigationController
//                                appSharedData.switchRootViewController(rootViewController: loginVC, animated: true) {
//                                    appSharedData.showAlertControllerWith(title: projectName, andMessage: json["message"] as? String ?? "")
//                                }
                            } else {
                                callback(json, nil)
                            }
                        }
                        if let json = try JSONSerialization.jsonObject(with:
                            taskD, options:.mutableLeaves) as? NSArray {
                            print("JSON :- \(json)")
                            callback(NSDictionary.init(dictionary: ["response":json]), nil)
                        }
                    }
                    
                } catch let error as NSError {
                    print("Error :- \(error.localizedDescription)")
                    callback(nil, error)
                }
            }
        }
        dataTask.resume()
    }
    
    
    func sendMultipartPostData(_ urlString:String, withParam paramDict:[String: Any],callback:@escaping (_ status:Bool,_ taskError:Error?)->Void)
    {
        if !Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.hide()
            appSharedData.showAlertControllerWith(title: projectName, andMessage: "The Internet connection appears to be offline.")
            return
        }
        let semaphore = DispatchSemaphore (value: 0)


        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        for (key, value) in paramDict {
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(key)\""
            body += "\r\n\r\n\(value)\r\n"
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                LoadingIndicatorView.hide()
                guard let data = data else {
                    callback(false,error)
                    print(String(describing: error))
                    return
                }
                print(String(data: data, encoding: .utf8)!)
                let result = String(data: data, encoding: .utf8)!
                if result == "success" || result == "1" {
                    callback(true,nil)
                }else {
                    callback(false,error)
                }
            }
                
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
    }
    
    func sendPostDataForCheckConnectionMode(_ urlString:String, withParam paramDict:[String: Any],callback:@escaping (_ connMode:String,_ taskError:Error?)->Void)
    {
        if !Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.hide()
            appSharedData.showAlertControllerWith(title: projectName, andMessage: "The Internet connection appears to be offline.")
            return
        }
        let semaphore = DispatchSemaphore (value: 0)


        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        for (key, value) in paramDict {
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(key)\""
            body += "\r\n\r\n\(value)\r\n"
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                LoadingIndicatorView.hide()
                guard let data = data else {
                    callback("",error)
                    print(String(describing: error))
                    return
                }
                print(String(data: data, encoding: .utf8)!)
                let result = String(data: data, encoding: .utf8)!
                callback(result,nil)
            }
                
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
    }
    
    func postRequestWithMultipPart(_ urlString:String, withParam paramDict:[String: Any],callback:@escaping (_ json:NSDictionary?,_ taskError:Error?)->Void)
    {
        if !Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.hide()
            appSharedData.showAlertControllerWith(title: projectName, andMessage: "The Internet connection appears to be offline.")
            return
        }
        let semaphore = DispatchSemaphore (value: 0)


        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        for (key, value) in paramDict {
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(key)\""
            body += "\r\n\r\n\(value)\r\n"
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)

        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                do {
                    
                    if let taskD = data {
                        
                        if let json = try JSONSerialization.jsonObject(with: taskD, options: .mutableLeaves) as? NSArray {
                            let dict = NSMutableDictionary()
                            dict.setValue(json, forKey: "response")
                            callback(dict, nil)

                        } else {
                            let json = try JSONSerialization.jsonObject(with: taskD, options: .mutableLeaves) as? NSDictionary
                            print("JSON :- \(json ?? nil)")
                            if let code: Int = json?["status"] as? Int,code == 401 {
//                                let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginNavigationController") as! UINavigationController
//                                appSharedData.switchRootViewController(rootViewController: loginVC, animated: true) {
//                                    appSharedData.showAlertControllerWith(title: projectName, andMessage: json?["message"] as? String ?? "")
//                                }
                            } else {
                                callback(json, nil)
                            }
                        }
                    }
                    
                } catch let error as NSError {
                    print("Error :- \(error.localizedDescription)")
                    callback(nil, error)
                }
            }
                
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
    }
    func sendMultipartPostDataWithMultipleImages(_ urlString:String, withPostData postData:[Data], imgParamName :NSString,withMutableDictionary paramDict:NSMutableDictionary,callback:@escaping (_ json:NSDictionary?,_ taskError:NSError?)->Void)
    {
        
        if !Reachability.isConnectedToNetwork() {
            LoadingIndicatorView.hide()
            appSharedData.showAlertControllerWith(title: projectName, andMessage: "The Internet connection appears to be offline.")
            return
        }
        print("Current Api -----",urlString)
        print("Current PostParameter -----",paramDict)
        
        let url = URL(string: urlString)!
        
        let urlRequest  = NSMutableURLRequest()
        urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        urlRequest.httpShouldHandleCookies = false
        urlRequest.timeoutInterval = 100.0
        urlRequest.httpMethod = "POST"
        
        let myboundary : NSString = "******GiftAppFileUpload******"
        
        let contentType : NSString = NSString(format: "multipart/form-data; boundary=%@", myboundary)
        
        urlRequest.setValue(contentType as String, forHTTPHeaderField:"Content-Type")
        
        let body = NSMutableData()
        
        for key in paramDict.allKeys
            
        {
            
            let tempStringValue = paramDict.object(forKey: key) as! NSString
            
            let tempStringKey = key as! NSString //paramDict.valueForKey(key as! String) as! NSString
            
            
            
            body.append(NSString(format: "--%@\r\n", myboundary).data(using: String.Encoding.utf8.rawValue)!)
            
            //print(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempStringKey))
            
            body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempStringKey).data(using: String.Encoding.utf8.rawValue)!)
            
            
            
            body.append(NSString(format: "%@\r\n",tempStringValue).data(using: String.Encoding.utf8.rawValue)!)
            
            
        }
        
        
        let postDataString  =  NSString(data: body as Data, encoding: String.Encoding.utf8.rawValue)
        print("*********** Data to be uplaoded all keys and values ************")
        print(postDataString)
        print("*********** End ************")
        
        let fileName = "petpic.jpeg"//:NSString = NSString(format: "%f.png",NSDate().timeIntervalSince1970)
        
        
        
        if postData.count > 0 {
            
            for i in 0..<postData.count {
                
                body.append(NSString(format: "--%@\r\n", myboundary).data(using: String.Encoding.utf8.rawValue)!)
                
                
                body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",((imgParamName as String) + "\(i)")).data(using: String.Encoding.utf8.rawValue)!)
                
                
                body.append(("Content-Type: image/*\r\n\r\n").data(using: String.Encoding.utf8)!)
                
                
                body.append(postData[i])
                
                
                body.append(("\r\n").data(using: String.Encoding.utf8)!)
                
                
            }
        }
        
        
        body.append(NSString(format: "\r\n--%@--\r\n", myboundary).data(using: String.Encoding.utf8.rawValue)!)
        
        urlRequest.httpBody = body as Data
        
        urlRequest.url = url
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = ["Content-Type":"application/json"]
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let dataTask = session.dataTask(with: urlRequest as URLRequest) { (taskData, taskResponse, taskError) in
            
            DispatchQueue.main.async {
                
                do {
                    
                    if let taskD = taskData {
                        
                        let json = try JSONSerialization.jsonObject(with: taskD, options: .mutableLeaves) as? NSDictionary
                        print("JSON :- \(json!)")
                        if let code: Int = json?["status"] as? Int,code == 401 {
//                            let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "loginNavigationController") as! UINavigationController
//                            appSharedData.switchRootViewController(rootViewController: loginVC, animated: true) {
//                                appSharedData.showAlertControllerWith(title: projectName, andMessage: json?["message"] as? String ?? "")
//                            }
                        } else {
                            callback(json, nil)
                        }
                    }
                    
                } catch let error as NSError {
                    print("Error :- \(error.localizedDescription)")
                    callback(nil, error)
                }
            }
        }
        dataTask.resume()
        
    }
}

