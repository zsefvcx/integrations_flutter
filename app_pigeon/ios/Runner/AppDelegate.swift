import UIKit
import Flutter
//import Foundation

//extension DataSender {
//    func send(data: SendData) throws -> SenderStatus? {
//
//    }
//}
//
class SenderDtPlugin: NSObject, DataSender {
    private let sink: DataReceiver

    init(binaryMessenger: FlutterBinaryMessenger) {
        sink = DataReceiver(binaryMessenger: binaryMessenger)
        super.init()
        DataSenderSetup.setUp(binaryMessenger: binaryMessenger, api: self)
    }

    func send(data: SendData) throws -> SenderStatus {

        var rcvData = ReceiveData()
        rcvData.data = data.data

        sink.receive(data: rcvData, completion: {})

        var result = SenderStatus()
        result.resultSuccessful = true
        result.hasError = false
        result.error = nil

        return result
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  private var senderDtPlugin: SenderDtPlugin?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {
          senderDtPlugin = SenderDtPlugin(binaryMessenger: controller.binaryMessenger)
     }
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
