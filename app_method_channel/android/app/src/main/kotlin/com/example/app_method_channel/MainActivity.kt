package com.example.app_method_channel

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import androidx.annotation.NonNull
import kotlinx.coroutines.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class MainActivity: FlutterActivity() {
    private val eventsChannel   = "CALL_EVENTS"
    private val methodChannelId = "CALL_METHOD"
    private val intentName      = "EVENTS"
    private val intentMassageId = "CALL"

    private var receiver: BroadcastReceiver? = null
    lateinit var job: Job

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelId).setMethodCallHandler{
            call, result ->
            if (call.method == intentMassageId){
                result.success(call.arguments as String)
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
                object : EventChannel.StreamHandler {
                    @SuppressLint("UnspecifiedRegisterReceiverFlag")
                    override fun onListen(args: Any?, events: EventChannel.EventSink) {
                        val intent = Intent(intentName)
                        receiver = createReceiver(events)
                        applicationContext?.registerReceiver(receiver, IntentFilter(intentName))
                        job = CoroutineScope(Dispatchers.Default).launch {
                            delay(timeMillis = 1000)
                            intent.putExtra(
                                    methodChannelId,
                                    "1"
                            )
                            delay(timeMillis = 1000)
                            intent.putExtra(
                                    methodChannelId,
                                    "2"
                            )
                            delay(timeMillis = 1000)
                            intent.putExtra(
                                    methodChannelId,
                                    "3"
                            )
                            delay(timeMillis = 1000)
//                            intent.putExtra(
//                                   methodChannelId,
//                                   args as String
//                            )
                        }
                    }

                    override fun onCancel(arguments: Any?) {
                        job.cancel()
                        receiver = null
                    }

                }
        )
    }
    fun createReceiver(events: EventChannel.EventSink): BroadcastReceiver {
        return object : BroadcastReceiver(){
            override fun onReceive(context: Context, intent: Intent) {
                events.success(intent.getIntExtra(intentMassageId, 0))
            }
        }

    }
}
