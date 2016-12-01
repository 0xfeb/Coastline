
//
//  BarCodeScanner.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit
import AVFoundation

public class CLBarCodeScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
	var session:AVCaptureSession?
	var device:AVCaptureDevice?
	var input:AVCaptureDeviceInput?
	var layer:AVCaptureVideoPreviewLayer?
	var output:AVCaptureMetadataOutput?
	
	var fetchCode:(AVMetadataMachineReadableCodeObject) -> () = { _ in }
	
	override init() {
		session = AVCaptureSession()
		device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
		input = try! AVCaptureDeviceInput(device: device)
		if ((session?.canAddInput(input)) != nil) {
			session?.addInput(input)
		}
		layer = AVCaptureVideoPreviewLayer(session: session)
		layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
		output = AVCaptureMetadataOutput()
		if ((session?.canAddOutput(output)) != nil) {
			session?.addOutput(output)
		}
	}
	
	func bindLayer(_ view:UIView) {
		layer?.frame = view.bounds
		layer?.masksToBounds = true
		layer?.cornerRadius = 5.0
		view.layer.addSublayer(layer!)
	}
	
	func getCode(_ response:@escaping (AVMetadataMachineReadableCodeObject) -> ()) {
		fetchCode = response
		
		let queue = DispatchQueue(label: "com.shutong.warehouse", attributes: [])
		output?.setMetadataObjectsDelegate(self, queue: queue)
	}
	
	func start() {
		session?.startRunning()
	}
	
	func stop() {
		session?.stopRunning()
	}
	
	public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
		if let obj = metadataObjects.filter({ $0 is AVMetadataMachineReadableCodeObject }).first as? AVMetadataObject {
			if let code = layer?.transformedMetadataObject(for: obj) as? AVMetadataMachineReadableCodeObject {
				fetchCode(code)
			}
		}
	}
}
