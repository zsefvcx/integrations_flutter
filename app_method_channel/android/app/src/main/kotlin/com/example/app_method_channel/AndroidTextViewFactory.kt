package com.example.app_method_channel

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class AndroidTextViewFactory(messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    private val binaryMessenger : BinaryMessenger = messenger
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val createParams = args as Map<String?, Any?>?
        println("args: $args")
        return AndroidTextView(context, viewId, createParams, binaryMessenger)
    }
}