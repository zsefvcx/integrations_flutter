package com.example.app_pigeon

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.SenderDataPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){

        flutterEngine.plugins.add(SenderDataPlugin())
        super.configureFlutterEngine(flutterEngine)
    }

    @Suppress("RedundantOverride")
    override fun onDestroy() {
        super.onDestroy()
    }
}

