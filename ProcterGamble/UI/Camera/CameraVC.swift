////
////  Camera.swift
////  ProcterGamble
////
////  Created by Rita Zemaitis on 10/04/2018.
////  Copyright © 2018 Rita Zemaitis. All rights reserved.
////


import Foundation
import AVFoundation
import UIKit

class CameraVC: UIViewController, CameraViewDelegate {
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var netBackgraund: UIImageView!
    @IBOutlet weak var vector_one: UIImageView!
    @IBOutlet weak var vector_four: UIImageView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var shoot_text: UIImageView!
    @IBOutlet weak var shooting_text: UIImageView!    

    /// contains video preview layer
    var previewView: AVPreviewView = {
        let view = AVPreviewView(frame: .zero)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    var cameraPresenter: CamerePresenter! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewView)
        previewView.fillSuperview()
        cameraPresenter = CamerePresenter(view: self, previewView: self.previewView)
        bringSubviewAllComponents()
    }

    func bringSubviewAllComponents(){
        self.view.bringSubview(toFront: netBackgraund)
        self.view.bringSubview(toFront: vector_one)
        self.view.bringSubview(toFront: vector_four)
        self.view.bringSubview(toFront: shoot_text)
        self.view.bringSubview(toFront: shooting_text)
//        self.view.bringSubview(toFront: back)
        self.view.bringSubview(toFront: photoButton)
    }

    @IBAction func photoPressed(_ sender: Any) {
        cameraPresenter?.photoPressed()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // Listeners
    /////
    
    func pushPhotoVC(didCapturePhotoData: Data){
        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVC") as? PhotoVC {
            presentedViewController.image = UIImage(data: didCapturePhotoData)!
            self.present(presentedViewController, animated: true, completion: nil)
        }
    }
}
