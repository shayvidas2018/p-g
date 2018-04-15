//
//  HomePageModel.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation

protocol transferLanguge {
    func langugeSelected(lang: String)
}

class HomePageModel {
    var transferLangugeDelegate: transferLanguge?
    init() {}
    
    func pressStart(lang: String)  {
        transferLangugeDelegate?.langugeSelected(lang: lang)
    }
    
}





