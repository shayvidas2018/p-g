//
//  FetchRequest.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import Alamofire




protocol ImageApi {
    func uploadImage(image: UIImage) ->String
    func sendSMS(phoneNum: String, message: String) -> Bool
//    func downloadImage(str: String)
//    func uploadImage1(str: String)
}


// sharedInstance.sharedInstance.upload(image: image)
final class ImageApiManager : ImageApi {
    //static let sharedInstance = AppManager()
     init(){}
    func uploadImage(image: UIImage) ->String {
        var message = ""
//        let imgData = UIImageJPEGRepresentation(image, 1)!
        var url = "https://procter-gamble-israel-mdo-ltd.appspot.com/predict"
        url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {
            return message
        }
       
        //   let parameters = ["name": rname] //Optional for extra parameter

        Alamofire.upload(imageData, to: URL(string: url)!, method: .post, headers: nil).responseJSON { (response) in
            if let JSON = response.result.value as? NSDictionary {
                message = response.result.description
                print(JSON)
            } else {
                 message = response.result.error != nil ? response.result.error!.localizedDescription : "Unable to communicate."
                print(message)
            }
        }
        
        return message
    }
    
    func sendSMS(phoneNum: String, message: String) -> Bool{
//        if let accountSID = ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"],
//            let authToken = ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"] {
//
//            let url = "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages"
//            let parameters = ["From": "YOUR_TWILIO_NUMBER", "To": "YOUR_PERSONAL_NUMBER", "Body": "Hello from Swift!"]
//
//            Alamofire.request(url, method: .post, parameters: parameters)
//                .authenticate(user: accountSID, password: authToken)
//                .responseJSON { response in
//                    debugPrint(response)
//            }
//
//            RunLoop.main.run()
//        }
        
        return true
    }
    
}





