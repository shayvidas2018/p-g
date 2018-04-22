//
//  Protocols.swift
//  ProcterGamble
//
//  Created by Rita Zemaitis on 22/04/2018.
//  Copyright © 2018 Rita Zemaitis. All rights reserved.
//

import Foundation

protocol CameraViewDelegate: class {
    func pushPhotoVC(didCapturePhotoData: Data)
}

protocol CameraPresenterDelegate: class {
    func presenterCaptureSession(didCapturePhotoData: Data)
}
