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
                println("args: ${call.arguments}")
                result.success(call.arguments)
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(args: Any?, events: EventChannel.EventSink) {
                        val intent = Intent(intentName)
                        receiver = createReceiver(events)
                        applicationContext?.registerReceiver(receiver, IntentFilter(intentName))
                        job = CoroutineScope(Dispatchers.Default).launch {
                            println("args: $args")

                            intent.putExtra(
                                    intentMassageId,
                                    "0"
                            )
                            applicationContext?.sendBroadcast(intent)
                            delay(timeMillis = 1000)
                            intent.putExtra(
                                    intentMassageId,
                                    "1"
                            )
                            applicationContext?.sendBroadcast(intent)
                            delay(timeMillis = 1000)
                            intent.putExtra(
                                    intentMassageId,
                                    "2"
                            )
                            applicationContext?.sendBroadcast(intent)
                            delay(timeMillis = 1000)
                            intent.putExtra(
                                    intentMassageId,
                                   args as String?
                            )
                            applicationContext?.sendBroadcast(intent)
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
                events.success(intent.getStringExtra(intentMassageId))
            }
        }

    }
}
