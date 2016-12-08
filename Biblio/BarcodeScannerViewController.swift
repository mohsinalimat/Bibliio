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
    case invalidBarcode
}

protocol BarcodeScannerDelegate: NSObjectProtocol {
    
    func barcodeScanner(_ viewController: BarcodeScannerViewController, didFailWith: Error)
    func barcodeScanner(_ viewController: BarcodeScannerViewController, didSucceedWith: Book)
}

class BarcodeScannerViewController: UIViewController {
    
    weak var delegate: BarcodeScannerDelegate?
    fileprivate var processingBarcode = false
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var client = APIClient.authenticatedAPIClient()
    
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
    
    // MARK: - Helper
    
    func handleBarcode(_ code: String) {
        
        let trimmedCode = code.trimmingCharacters(in: CharacterSet.whitespaces)
        
        let work = { [unowned self] in
            self.session.stopRunning()
            self.dismiss(animated: true, completion: nil)
            self.processingBarcode = false
        }
        
        client?.search(trimmedCode, success: { [unowned self] (book) in
            self.delegate?.barcodeScanner(self, didSucceedWith: book)
            work()
        }, failure: { (error) in
            self.delegate?.barcodeScanner(self, didFailWith: error)
            work()
        })
    }
}

extension BarcodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if processingBarcode == true {
            return
        }
        if let barcodeData = metadataObjects.first {
            
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
            
            if let readableCode = barcodeReadable {
                processingBarcode = true
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                handleBarcode(readableCode.stringValue);
            }
        }
    }
}
