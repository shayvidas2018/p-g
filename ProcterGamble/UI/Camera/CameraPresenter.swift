//
//  CameraPresenter.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class CamerePresenter: CameraPresenterDelegate{
   
    var cameraView : CameraViewDelegate
    var cameraModel : CamereModel! = nil    

    init(view: CameraViewDelegate, previewView: AVPreviewView) {
        self.cameraView = view
        self.cameraModel = CamereModel(view: self)
        self.cameraModel.viewDidLoaded(previewView: previewView)
    }

    func presenterCaptureSession(didCapturePhotoData: Data) {
        self.cameraView.pushPhotoVC(didCapturePhotoData: didCapturePhotoData)
    }
    
    func photoPressed(){
        cameraModel.photoPressed()
    }
    
}
