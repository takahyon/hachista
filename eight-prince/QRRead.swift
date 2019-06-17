//
//  QRRead.swift
//  eight-prince
//
//  Created by taka on 2019/06/10.
//  Copyright © 2019 takapc. All rights reserved.
//

import UIKit
import AVFoundation

class QRRead: UIViewController,AVCaptureMetadataOutputObjectsDelegate,UITabBarDelegate {
    
    // セッションのインスタンス生成
    let captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    @IBOutlet weak var textField: UILabel!
    @IBOutlet weak var topbar: UITabBar!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topbar.delegate = self

        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            self.captureSession.startRunning()
            view.bringSubviewToFront(textField)
            //view.bringSubviewToFront(topbar)
            
            qrCodeFrameView = UIView()
            // スキャンしたQRコードを緑の枠で囲む
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
                view.bringSubviewToFront(topbar)
            }
            
        } catch {
            
            print(error)
            return
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            textField.text = "QRコードをかざしてください"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                textField.text = metadataObj.stringValue
            }
        }
    }
    
    func init_camera(){
        // 入力（背面カメラ）
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice!)
        captureSession.addInput(videoInput)
        
        // 出力（メタデータ）
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
            // 複数のメタデータを検出できる
            for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
                // QRコードのデータかどうかの確認
                if metadata.type == AVMetadataObject.ObjectType.qr {
                    if metadata.stringValue != nil {
                        // 検出データを取得
                        textField.text = metadata.stringValue!
                    }
                }
            }
        }
    }
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            //昼画面を表示する。
            1+2
        case 0:
            //夕方画面を表示する。
            jaran()
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "sightspot") as! jaran
            
            self.present(resultViewController, animated:true, completion:nil)
        default:
            return
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
