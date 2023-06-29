//
//  CameraViewController.swift
//  Instruments Demo App
//
//  Created by Dominik Gail on 05.04.23.
//

import UIKit
import AVFoundation
import Accelerate

class CameraViewController: UIViewController {
    
    var totalImages: Int?
    var sequenceRate: Int?
    
    private let camera = Camera()
    private let imageStore = ImageStore()
    private var lastStoredImageTimestamp: TimeInterval?
    
    private let previewLayer = AVCaptureVideoPreviewLayer()
    private let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        camera.delegate = self
        camera.startCamera()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        previewLayer.frame = view.frame
    }
    
}

// MARK: - Store images
extension CameraViewController {
    
    private func askUserToStoreImages() {
        DispatchQueue.main.async { [weak self] in
            guard let alertController = self?.createStoreAlert() else { return }
            self?.present(alertController, animated: true)
        }
    }
    
    private func createStoreAlert() -> UIAlertController {
        let alertController = UIAlertController(title: "Store images", message: "Do you want to store \(totalImages ?? 0) sequenced images?", preferredStyle: .actionSheet)
        let storeAction = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            self?.storeImages()
        })
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(storeAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    private func storeImages() {
        imageStore.writeImages { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

// - MARK: CameraDelegate
extension CameraViewController: CameraDelegate {
    
    func startedCamera(session: AVCaptureSession) {
        previewLayer.session = session
    }
    
    func didCapture(sampleBuffer: CMSampleBuffer) {
        guard shouldStoreImage(),
              let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        else { return }
        
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let data = ImageCopy.copy(buffer: pixelBuffer)
        imageStore.store(image: Image(rawData: data, width: width, height: height))
        
        if imageStore.size() == totalImages {
            camera.stopCamera()
            askUserToStoreImages()
        }
    }
    
    private func shouldStoreImage() -> Bool {
        guard imageStore.size() < totalImages ?? 0 else { return false }
        
        let currentTimeStamp = Date().timeIntervalSince1970
        var shouldStore: Bool
        if let lastStoredImageTimestamp {
            shouldStore = currentTimeStamp - lastStoredImageTimestamp > minImageTimestampDifference()
        } else {
            shouldStore = true
        }
        
        if shouldStore {
            lastStoredImageTimestamp = currentTimeStamp
        }
        
        return shouldStore
    }
    
    private func minImageTimestampDifference() -> Double {
        return 1.0 / Double(sequenceRate ?? 1)
    }
    
}
