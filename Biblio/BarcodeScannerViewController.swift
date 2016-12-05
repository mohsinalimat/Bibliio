//
//  BarcodeScannerViewController.swift
//  Bibliio
//
//  Created by Adam on 12/2/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import UIKit
import AVFoundation

enum BarcodeScannerError: Error {
    case deviceError
}

protocol BarcodeScannerDelegate: NSObjectProtocol {
    
    func barcodeScanner(_ viewController: BarcodeScannerViewController, didFailWith: BarcodeScannerError)
    func barcodeScanner(_ viewController: BarcodeScannerViewController, didSucceedWith: Book)
}

class BarcodeScannerViewController: UIViewController {

    weak var delegate: BarcodeScannerDelegate?
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCancelButton()
        
        do {
            try configureCaptureSession()
        } catch {
            self.delegate?.barcodeScanner(self, didFailWith: BarcodeScannerError.deviceError)
            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if session.isRunning == false {
            session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }
    
    // MARK: - Target Action
    
    func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup
    
    func configureCancelButton() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func configureCaptureSession() throws {
        
        session = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)

        let videoInput: AVCaptureInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            throw BarcodeScannerError.deviceError
        }
        
        guard session.canAddInput(videoInput) else {
           throw BarcodeScannerError.deviceError
        }
        session.addInput(videoInput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        guard session.canAddOutput(metadataOutput) else {
             throw BarcodeScannerError.deviceError
        }
        session.addOutput(metadataOutput)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        session.startRunning()
    }

}

extension BarcodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print("success")
        self.delegate?.barcodeScanner(self, didSucceedWith: Book())
        dismiss(animated: true, completion: nil)
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
