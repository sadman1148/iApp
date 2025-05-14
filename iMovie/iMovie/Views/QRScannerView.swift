//
//  QRScannerView.swift
//  iMovie
//
//  Created by Sadman on 14/5/25.
//

import UIKit
import AVFoundation

class QRScannerView: UIView, AVCaptureMetadataOutputObjectsDelegate {
    
    let session = AVCaptureSession()
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in QRScannerView")
    }
    
    private func setupCamera() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              session.canAddInput(videoInput)
        else { return }
        
        session.addInput(videoInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.qr]
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer!)
        captureSession = session
    }
    
    func stopScanning() {
        if session.isRunning {
            session.stopRunning()
        }
    }

    func startScanning() {
        if !session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
            }
        }
    }
    
    deinit {
        stopScanning()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
    
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue
            else { return }
            stopScanning()
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))  // Playing vibration on scan
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Decrypted Code", message: stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.startScanning()
                })
                self.parentViewController()?.present(alert, animated: true)
            }
            print("scan result: \(stringValue)")
        }
    }
}

extension UIView {
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            if let vc = responder as? UIViewController {
                return vc
            }
            parentResponder = responder.next
        }
        return nil
    }
}
