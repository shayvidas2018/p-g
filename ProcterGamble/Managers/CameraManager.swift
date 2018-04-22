//
//  CameraManager.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 22/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

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




