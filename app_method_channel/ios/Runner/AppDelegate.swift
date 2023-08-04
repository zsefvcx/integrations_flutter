import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
	let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
	
	let channel = FlutterMethodChannel(name: "CALL_METHOD",
											binaryMessenger: controller.binaryMessenger)
											
	let eventChannel = FlutterEventChannel(name: "CALL_EVENTS",
											binaryMessenger: controller.binaryMessenger)										
	
	GeneratedPluginRegistrant.register(with: self)
	
	channel.setMethodCallHandler({
		(call: FlutterMethodCall, result: FlutterResult) -> Void in
		guard call.method  == "CALL" else {
			result(FlutterMethodNotImplemented)
			return
		}
	
		eventChannel.setStreamHandler(StreamHandler())
	
		result(call.arguments)
	})
	
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class StreamHandler:NSObject, FlutterStreamHandler {

	func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
		//var count = 100
		//Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
		//	if (count == 20){
		//		timer.invalidate()
		//	}
            //events(call.arguments as String)
		//	count += 1
		//
		//}
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                // do stuff 1 seconds later
            }
        
        events("0")
        RunLoop.current.add(timer, forMode: .common)
        events("1")
        RunLoop.current.add(timer, forMode: .common)
        events("2")
        RunLoop.current.add(timer, forMode: .common)
        events(arguments as! String)

        
        
		return nil
	}

	func onCancel(withArguments arguments: Any?)-> FlutterError? {
		return nil	
	}
}
