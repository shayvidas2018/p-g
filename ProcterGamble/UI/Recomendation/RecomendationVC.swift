//
//  RecomendationVC.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 15/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class RecomendationVC: UIViewController{
    
    @IBOutlet weak var animation_image: UIImageView!
    @IBOutlet weak var getCoupon: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCoupon.isHidden = true
        let animationImages=[UIImage(named:"rec_one.jpg"),UIImage(named:"rec_two.jpg"),UIImage(named:"rec_three.jpg")]
        animation_image.animationImages=animationImages as? [UIImage]
        animation_image.animationDuration=TimeInterval(1*animationImages.count)
        //to make it loop infinitely
        animation_image.animationRepeatCount=0
        animation_image.startAnimating()
        // Do any additional setup after loading the view, typically from a nib.
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.stopAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func stopAnimation (){
        animation_image.stopAnimating()
        
        getCoupon.isHidden = false
    }
    
}
