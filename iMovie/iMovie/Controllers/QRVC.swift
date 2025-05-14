//
//  QRVC.swift
//  iMovie
//
//  Created by BARTA on 8/5/25.
//

import SwiftUI
import AVFoundation

class QRVC: UIViewController {
    
    var isShowingScanner = true
    private let scannerView = QRScannerView()
    private let generatorView = QRGeneratorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Generate",
            style: .plain,
            target: self,
            action: #selector(toggleView)
        )
        add(scannerView)
        scannerView.startScanning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scannerView.stopScanning()
    }
    
    @objc private func toggleView() {
        if isShowingScanner {
            scannerView.removeFromSuperview()
            scannerView.stopScanning()
            add(generatorView)
            navigationItem.rightBarButtonItem?.title = "Scan"
        } else {
            generatorView.removeFromSuperview()
            scannerView.startScanning()
            checkCameraAuthorization { granted in
                if granted {
                    self.add(self.scannerView)
                } else {
                    self.showCameraAccessAlert()
                }
            }
            navigationItem.rightBarButtonItem?.title = "Generate"
        }
        isShowingScanner.toggle()
    }
    
    private func showCameraAccessAlert() {
        let alert = UIAlertController(
            title: "Camera Access Needed",
            message: "Please allow camera access in Settings to scan QR codes.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }))

        self.present(alert, animated: true)
    }
    
    func checkCameraAuthorization(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted: completion(false)
        @unknown default: completion(false)
        }
    }
    
    private func add(_ subview: UIView) {
        view.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
