//
//  Photo.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoView: class {
    func goToCameraScreen()
}

class PhotoVC: UIViewController{
    
    var image: UIImage! = nil
    var presenter: PhotoPresenter! = nil
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PhotoPresenter()
        imageView.image = image
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tryAgainPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
//        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") {
//            self.present(presentedViewController, animated: true, completion: nil)
//        }
    }
    
    @IBAction func recomendationPressed(_ sender: UIButton) {
        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecomendationVC") {
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
    
//    // listeners
//    /////////
//    func  goToCameraScreen(){
//        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") {
//            self.present(presentedViewController, animated: true, completion: nil)
//        }
//    }
}




