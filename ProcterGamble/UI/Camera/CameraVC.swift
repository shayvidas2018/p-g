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

class CameraVC: UIViewController, CaptureSessionPhotoCapturingDelegate {

    @IBOutlet weak var photoButton: UIButton!
    fileprivate var captureSession: CaptureSession?
    public var captureSettings = CaptureSettings.default
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.addSubview(previewView)
        previewView.fillSuperview()


        let session = CaptureSession()
        captureSession = session
        session.presetConfiguration = captureSettings.cameraMode.captureSessionPresetConfiguration
        session.videoOrientation = UIApplication.shared.statusBarOrientation.captureVideoOrientation
        session.photoCapturingDelegate = self
        session.prepare()



        previewView.session = captureSession?.session
        captureSession?.previewLayer = previewView.previewLayer

        captureSession?.resume()
        self.view.bringSubview(toFront: netBackgraund)
        self.view.bringSubview(toFront: vector_one)
        self.view.bringSubview(toFront: vector_four)
        self.view.bringSubview(toFront: shoot_text)
        
        self.view.bringSubview(toFront: shooting_text)
        self.view.bringSubview(toFront: back)
        self.view.bringSubview(toFront: photoButton)
    }


    func captureSession(_ session: CaptureSession, willCapturePhotoWith settings: AVCapturePhotoSettings) {}

    /// called when captured photo is processed and ready for use
    func captureSession(_ session: CaptureSession, didCapturePhotoData: Data, with settings: AVCapturePhotoSettings) {

        if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVC") as? PhotoVC {
            presentedViewController.image = UIImage(data: didCapturePhotoData)!
            self.present(presentedViewController, animated: true, completion: nil)
        }

    }

    /// called when captured photo is processed and ready for use
    func captureSession(_ session: CaptureSession, didFailCapturingPhotoWith error: Error) {}

    /// called when number of processing live photos changed, see inProgressLivePhotoCapturesCount for current count
    func captureSessionDidChangeNumberOfProcessingLivePhotos(_ session: CaptureSession) {}

    @IBAction func photoPressed(_ sender: Any) {
        captureSession?.capturePhoto(livePhotoMode: .off, saveToPhotoLibrary: captureSettings.savesCapturedPhotosToPhotoLibrary)
//        if let videoConnection = stillImageOutput.connection(with: AVMediaType.video) {
//            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
//                (imageDataSampleBuffer, error) -> Void in
//                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!)
//
//                //AppManager.sharedInstance.getPhoto()
//                if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVC") as? PhotoVC {
//                    presentedViewController.image = UIImage(data: imageData!)
//                    self.present(presentedViewController, animated: true, completion: nil)
//                }
//
//                //                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
//            }
//        }
    }

//    @IBAction func back(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//        captureSession = nil
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        if (captureSession?.isRunning == false) {
//            captureSession.startRunning();
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if (captureSession?.isRunning == true) {
//            captureSession.stopRunning();
//        }
//    }

    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}




///
/// A view whose layer is AVCaptureVideoPreviewLayer so it's used for previewing
/// output from a capture session.
///
final class AVPreviewView: UIView {

    deinit {
        log("deinit: \(String(describing: self))")
    }

    var previewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }

    var session: AVCaptureSession? {
        get { return previewLayer.session }
        set {
            if previewLayer.session === newValue {
                return
            }
            previewLayer.session = newValue

        }
    }

    var displayMode: VideoDisplayMode = .aspectFill {
        didSet { applyVideoDisplayMode() }
    }

    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyVideoDisplayMode()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyVideoDisplayMode()
    }

    // MARK: Private Methods

    private func applyVideoDisplayMode() {
        switch displayMode {
        case .aspectFill:    previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        case .aspectFit:    previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        case .resize:       previewLayer.videoGravity = AVLayerVideoGravity.resize
        }
    }
}

enum VideoDisplayMode {
    /// Preserve aspect ratio, fit within layer bounds.
    case aspectFit
    /// Preserve aspect ratio, fill view bounds.
    case aspectFill
    ///Stretch to fill layer bounds
    case resize
}



public struct CaptureSettings {

    public enum CameraMode {
        ///
        /// If you support only photos use this preset. Default value.
        ///
        case photo
        ///
        /// If you know you will use live photos use this preset.
        ///
        case photoAndLivePhoto

        /// If you wish to record videos or take photos.
        case photoAndVideo
    }

    ///
    /// Capture session uses this preset when configuring. Select a preset of
    /// media types you wish to support.
    ///
    /// - note: currently you can not change preset at runtime
    ///
    public var cameraMode: CameraMode

    ///
    /// Return true if captured photos will be saved to photo library. Image picker
    /// will prompt user with request for permisssions when needed. Default value is false
    /// for photos. Live photos and videos are always true.
    ///
    /// - note: please note, that at current implementation this applies to photos only. For
    /// live photos and videos this is always true.
    ///
    public var savesCapturedPhotosToPhotoLibrary: Bool

    let savesCapturedLivePhotosToPhotoLibrary: Bool = true
    let savesCapturedVideosToPhotoLibrary: Bool = true

    /// Default configuration
    public static var `default`: CaptureSettings {
        return CaptureSettings(
            cameraMode: .photo,
            savesCapturedPhotosToPhotoLibrary: false
        )
    }
}

extension CaptureSettings.CameraMode {

    /// transforms user related enum to specific internal capture session enum
    var captureSessionPresetConfiguration: CaptureSession.SessionPresetConfiguration {
        switch self {
        case .photo: return .photos
        case .photoAndLivePhoto: return .livePhotos
        case .photoAndVideo: return .videos
        }
    }

}

extension UIView {
    @objc public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superview = superview {
            let viewsDictionary = ["view": self]
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
        }
    }
    
}
