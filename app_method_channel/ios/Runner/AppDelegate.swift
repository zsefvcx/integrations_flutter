import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
	
	GeneratedPluginRegistrant.register(with: self)
	
      weak var registrar = self.registrar(forPlugin: "integration-test")
      
      let factory = FLPlatformViewFactory(messager: registrar!.messenger())
      self.registrar(forPlugin: "<integration-test>")!.register(
            factory, withId: "INTEGRATION_IOS")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
