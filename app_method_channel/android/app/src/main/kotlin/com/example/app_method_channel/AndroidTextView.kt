package com.example.app_method_channel

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

internal class AndroidTextView(context: Context, id: Int, creationParams: Map<String?, Any?>?, messenger: BinaryMessenger): PlatformView {
    private val textView: TextView

    private val createParams = creationParams
    override fun getView(): View {

        return textView
    }

    override fun dispose() {
    }


    init {
        textView = TextView(context)
        textView.textSize = 72f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = createParams?.getValue("0") as String
    }

}