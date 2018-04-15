//
//  ViewController.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 08/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import UIKit

protocol HomePageView: class {
    func goToCameraScreen()
}

class HomePageVC: UIViewController, HomePageView{

   
    var presenter: HomePagePresenter! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
          presenter = HomePagePresenter(view: self)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func startPressed(_ sender: UIButton) {
        let tag = sender.tag
        presenter.pressStart(id: tag)
    }
    
    // listeners
    /////////
    func  goToCameraScreen(){
        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") {
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
}

