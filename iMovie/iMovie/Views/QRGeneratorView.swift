//
//  QRGeneratorView.swift
//  iMovie
//
//  Created by Sadman on 14/5/25.
//

import UIKit

class QRGeneratorView: UIView, UITextFieldDelegate {
    
    private let imageView = UIImageView()
    private let textField = UITextField()
    private let generateButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupUI()
        setupKeyboardDismissRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupKeyboardDismissRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // allow button taps to work
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    private func setupUI() {
        textField.placeholder = "Enter your text"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        generateButton.setTitle(" Generate QR Code", for: .normal)
        generateButton.setImage(UIImage(systemName: "qrcode"), for: .normal)
        generateButton.addTarget(self, action: #selector(generateQRCode), for: .touchUpInside)
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        
        let stack = UIStackView(arrangedSubviews: [imageView, textField, generateButton])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        imageView.isHidden = true
    }
    
    @objc private func generateQRCode() {
        guard let text = textField.text else { return }
        
        let data = text.data(using: .ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            if let outputImage = filter.outputImage {
                let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
                let uiImage = UIImage(ciImage: scaledImage)
                imageView.image = uiImage
                imageView.isHidden = false
            }
        }
    }
}
