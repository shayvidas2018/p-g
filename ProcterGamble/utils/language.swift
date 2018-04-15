//
//  language.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation

class Language{
    static  func getLanguage(id: Int) -> String{
        switch(id) {
        case 1:
            return "english"
        case 2:
            return "hebrew"
        default:
            return "";
        }
    }
}
