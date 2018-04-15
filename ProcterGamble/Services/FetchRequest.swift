//
//  FetchRequest.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
//import Alamofire
//
//
//
//
//protocol ImageApi {
//    func uploadImage(str: String)
//    func downloadImage(str: String)
//    func uploadImage1(str: String)
//}
//
//protocol LoginApi {
//    func login(str: String)
//}
//
//// sharedInstance.sharedInstance.upload(image: image)
//final class ImageApiManager: LangaugesProtocol {
//    static let sharedInstance = AppManager()
//    private init(){}
//    func uploadImage(image: UIImageView, handler: (() -> (Bool))) {
//
//        let imgData = UIImageJPEGRepresentation(image!, 1)!
//
//        //   let parameters = ["name": rname] //Optional for extra parameter
//
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
//        }, to:"mysite/upload.php")
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//
//                upload.responseJSON { response in
//                    print(response.result.value)
//                    handler(true)
//                }
//
//            case .failure(let encodingError):
//                print(encodingError)
//                handler(false)
//            }
//        }
//
//    }
//}
//
