package com.example.app_pigeon

import io.flutter.plugins.SenderData
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){

        //flutterEngine.plugins.add(SenderData())
        super.configureFlutterEngine(flutterEngine)
    }

    @Suppress("RedundantOverride")
    override fun onDestroy() {
        super.onDestroy()
    }
}

