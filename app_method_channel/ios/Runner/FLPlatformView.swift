//
//  FLPlatformView.swift
//  Runner
//
//  Created by Виктор Д on 08.08.2023.
//

import Flutter
import UIKit

class FLPlatformViewFactory: NSObject, FlutterPlatformViewFactory{
    private var messager: FlutterBinaryMessenger
    
    init(messager: FlutterBinaryMessenger){
        self.messager = messager
        super.init()
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?) -> FlutterPlatformView {
            return FLPlatformView(
                frame: frame,
                viewIdentifer: viewId,
                arguments: args,
                bynaryMesseger: messager
            )
    }
}

class FLPlatformView: NSObject, FlutterPlatformView, FlutterStreamHandler {
    private var _view: UIView
    private var _eventSink: FlutterEventSink!
    
    init(
        frame: CGRect,
        viewIdentifer viewId: Int64,
        arguments arg: Any?,
        bynaryMesseger messager: FlutterBinaryMessenger
    ){
        _view = UIView()
        super.init()
        // iOS views can be created here
                debugPrint("Arguments ")
                debugPrint(arg!)
                debugPrint(messager)
        var args = ["0":"Hello from IOS"]
        if let arg1 = arg
        {
            args["0"] = (arg1 as! [String:String])["0"]
        } else {
            //args["0"] = (arg as? [String:String])["0"]
        }
        
        
        createNativeView(view: _view, bynaryMesseger: messager, arguments: args)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink  ) -> FlutterError? {
        _eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
    
    func createNativeView(view _view: UIView, bynaryMesseger messager: FlutterBinaryMessenger, arguments arg: [String:String]){
        
        let textView = UITextView()
        textView.text = arg["0"]
        textView.backgroundColor = UIColor.lightGray
        textView.frame = CGRect(x: 0, y: 0, width: 180.0, height: 48.0)
        _view.addSubview(textView)
        
        let channel = FlutterMethodChannel(name: "CALL_METHOD", binaryMessenger: messager)
        let eventChannel = FlutterEventChannel(name: "CALL_EVENTS", binaryMessenger: messager)
        
        eventChannel.setStreamHandler(StreamHandler())
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in guard call.method == "CALL" else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(call.arguments)
            
        })
        
        
        
    }
}

class StreamHandler:NSObject, FlutterStreamHandler {

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        //var count = 100
        //Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        //    if (count == 20){
        //        timer.invalidate()
        //    }
            //events(call.arguments as String)
        //    count += 1
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
            events("2")
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
