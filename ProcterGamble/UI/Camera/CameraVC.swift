////
////  Camera.swift
////  ProcterGamble
////
////  Created by Rita Zemaitis on 10/04/2018.
////  Copyright © 2018 Rita Zemaitis. All rights reserved.
////



import AVFoundation
import UIKit

class CameraVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    let stillImageOutput = AVCaptureStillImageOutput()
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var photoButton: UIButton!
    
    @IBOutlet weak var netBackgraund: UIImageView!
    @IBOutlet weak var vector_one: UIImageView!
    @IBOutlet weak var vector_four: UIImageView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var shoot_text: UIImageView!
    @IBOutlet weak var shooting_text: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecType.jpeg]
        if captureSession.canAddOutput(stillImageOutput) {
            captureSession.addOutput(stillImageOutput)
        }
        
//        self.view.bringSubview(toFront: customView)
        
        self.view.bringSubview(toFront: netBackgraund)
        self.view.bringSubview(toFront: vector_one)
        self.view.bringSubview(toFront: vector_four)
        self.view.bringSubview(toFront: shoot_text)
        
        self.view.bringSubview(toFront: shooting_text)
        self.view.bringSubview(toFront: back)
        self.view.bringSubview(toFront: photoButton)
    }
    
    @IBAction func photoPressed(_ sender: Any) {
        if let videoConnection = stillImageOutput.connection(with: AVMediaType.video) {
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!)
                
                //AppManager.sharedInstance.getPhoto()
                if let presentedViewController = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVC") as? PhotoVC {
                    presentedViewController.image = UIImage(data: imageData!)
                    self.present(presentedViewController, animated: true, completion: nil)
                }
                
                //                UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
            }
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
