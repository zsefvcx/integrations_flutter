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

        //print(call.arguments)
		result(call.arguments)
	})

	eventChannel.setStreamHandler(StreamHandler())

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
        //print(arguments as! String)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            print("async after 1000 milliseconds")
            events("0")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)) {
            print("async after 2000 milliseconds")
            events("1")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
            print("async after 3000 milliseconds")
            events("3")
        }


         DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(4000)) {
            print("async after 4000 milliseconds")
            events(arguments as! String)
         }
        
		return nil
	}

	func onCancel(withArguments arguments: Any?)-> FlutterError? {
		return nil	
	}
}
