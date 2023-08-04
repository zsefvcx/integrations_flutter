import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
	let controller : FlutterViewConrtoller = windowa?.rootViewController as! FlutterViewConrtoller
	
	let channel = FlutterMethodChannel(name: "CALL_METHOD",
											binaryMessenger: controller.binaryMessenger)
											
	let eventChannel = FlutterMethodChannel(name: "CALL_EVENTS",
											binaryMessenger: controller.binaryMessenger)										
	
	GeneratedPluginRegistrant.register(with: self)
	
	channel.setMethodCallHandler({
		(call: FlutterMethodCall, result: FlutterResult) -> Void in
		guard call.method  == "CALL" else {
			result(FlutterMethodImplemented)
			return
		}
	
		eventChannel.setStreamHandler(StreamHandler())
	
		result(Int.random(in:0..<500))
	})
	
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class StreamHandler:NSObject, FlutterStreamHandler {

	func onListen(withArguments arguments: Any?, eventSink event: @escaping FlutterEventSinc) -> FlutterError? {
		var count = 100
		Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
			if (count == 20){
				timer.invaalidate()
			}
			events(Int.random(in: 0..<500))
			count += 1
		
		}
		return nil
	}

	func onCancel(withArguments arguments: Any?)-> FlutterError? {
		return nil	
	}
}