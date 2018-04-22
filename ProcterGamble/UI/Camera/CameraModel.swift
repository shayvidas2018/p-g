//
//  CameraModel.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 10/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class CamereModel: CaptureSessionPhotoCapturingDelegate{
    
    fileprivate var captureSession: CaptureSession?
    public var captureSettings = CaptureSettings.default
    var cameraPresenterDelegate: CameraPresenterDelegate
    
    init(view: CameraPresenterDelegate) {
       self.cameraPresenterDelegate = view
    }
    
    func viewDidLoaded(previewView: AVPreviewView){
        
        let session = CaptureSession()
        captureSession = session
        session.presetConfiguration = captureSettings.cameraMode.captureSessionPresetConfiguration
        session.videoOrientation = UIApplication.shared.statusBarOrientation.captureVideoOrientation
        session.photoCapturingDelegate = self
        session.prepare()
        previewView.session = captureSession?.session
        captureSession?.previewLayer = previewView.previewLayer
        captureSession?.resume()
    }
    
    func captureSession(_ session: CaptureSession, willCapturePhotoWith settings: AVCapturePhotoSettings) {}
    
    /// called when captured photo is processed and ready for use
    func captureSession(_ session: CaptureSession, didCapturePhotoData: Data, with settings: AVCapturePhotoSettings) {
        cameraPresenterDelegate.presenterCaptureSession(didCapturePhotoData: didCapturePhotoData)
    }
    
    /// called when captured photo is processed and ready for use
    func captureSession(_ session: CaptureSession, didFailCapturingPhotoWith error: Error) {}
    
    /// called when number of processing live photos changed, see inProgressLivePhotoCapturesCount for current count
    func captureSessionDidChangeNumberOfProcessingLivePhotos(_ session: CaptureSession) {}
    
    func photoPressed(){
        captureSession?.capturePhoto(livePhotoMode: .off, saveToPhotoLibrary: captureSettings.savesCapturedPhotosToPhotoLibrary)
    }
}
