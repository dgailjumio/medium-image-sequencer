//
//  Camera.swift
//  Image Sequencer
//
//  Created by Dominik Gail on 04.05.23.
//

import AVFoundation

protocol CameraDelegate {
    func startedCamera(session: AVCaptureSession)
    func didCapture(sampleBuffer: CMSampleBuffer)
}

class Camera: NSObject {
    
    var delegate: CameraDelegate?
    
    private var session = AVCaptureSession()
    private let processingQueue = DispatchQueue(label: "com.jumio.camera.processing", qos: .utility)
    
    func startCamera() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] success in
            guard let self = self, success else { return }
            
            self.setupCaptureSession()
            self.setupCaptureOutput()
            self.startSession()
            self.delegate?.startedCamera(session: self.session)
        })
    }
    
    func stopCamera() {
        stopSession()
    }
    
    private func setupCaptureSession() {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: AVMediaType.video,
                                                                position: .unspecified)
        
        guard let camera = discoverySession.devices.compactMap({ $0 }).first(where: { $0.position == .back }),
              let input = try? AVCaptureDeviceInput(device: camera) else { return }
        
        session.addInput(input)
        session.sessionPreset = AVCaptureSession.Preset.hd1280x720
    }
    
    private func setupCaptureOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA]
        videoOutput.setSampleBufferDelegate(self, queue: processingQueue)
        
        session.addOutput(videoOutput)
    }
    
    private func startSession() {
        session.startRunning()
    }
    
    private func stopSession() {
        session.stopRunning()
    }
    
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        delegate?.didCapture(sampleBuffer: sampleBuffer)
    }
    
}
