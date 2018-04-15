//
//  AppManager.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import UIKit

protocol LangaugesProtocol {
    func setLanguage(str: String)
    
}
protocol HomePageBack {
    func goToHomePage()
}
final class AppManager: LangaugesProtocol {
    static let sharedInstance = AppManager()
    private init(){}
    func setLanguage(str: String) {
        
    }
//    func goToHomePage(){
//        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVC") {
//            self.present(presentedViewController, animated: true, completion: nil)
//        }
//    }
    
    
}

