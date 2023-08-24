//
//  AppFluMiOsApp.swift
//  AppFluMiOs
//
//  Created by Виктор Д on 24.08.2023.
//

import SwiftUI
import Flutter
// The following library connects plugins with iOS platform code to this app.
import FlutterPluginRegistrant

class FlutterDependencies: ObservableObject {
  let flutterEngine = FlutterEngine(name: "my flutter engine")
    
  //private var messager: FlutterBinaryMessenger
    
  init(){
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run()
    // Connects plugins with iOS platform code to this app.
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
  }
}

@main
struct AppFluMiOsApp: App {
    // flutterDependencies will be injected using EnvironmentObject.
    @StateObject var flutterDependencies = FlutterDependencies()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(flutterDependencies)
    
        }
    }
}
