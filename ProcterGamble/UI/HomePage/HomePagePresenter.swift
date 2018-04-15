//
//  HomePagePresenters.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation

class HomePagePresenter  {
    var view: HomePageView
    init(view: HomePageView) {
        self.view = view
    }
    let homePageModel = HomePageModel()
    
    func pressStart(id: Int){
        homePageModel.pressStart(lang: Language.getLanguage(id: id))
        goToCameraScreen()
    }

    
    func goToCameraScreen (){
        self.view.goToCameraScreen()
    }
  
}
