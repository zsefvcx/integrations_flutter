package io.flutter.plugins

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin

class SenderDataPlugin : FlutterPlugin, SenderData.DataSender {

    private  companion object {
        ///Тэг плагина
        private const val TAG = "SenderDataPlugin"

        /// Взаимодействие с подключенным Flutter Engine
        private var sink : SenderData.DataReceiver? = null

        private var dataReceive : SenderData.SendData? = null
    }
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            //Зарегистрируем метот ченелы
            SenderData.DataSender.setup(binding.binaryMessenger, this)
            sink = SenderData.DataReceiver(binding.binaryMessenger)
        } catch (error: Throwable ) {
            Log.e(TAG, "Произошло непредвиденеое исключение при подключении SenderDataPlugin.")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        try {
            SenderData.DataSender.setup(binding.binaryMessenger, null)
            sink = null
        } catch (error: Throwable ) {
            Log.e(TAG, "Произошло непредвиденеое исключение при отключении SenderDataPlugin.")
        }
    }

    override fun send(data: SenderData.SendData): SenderData.SenderStatus {
        try {
            Log.i(TAG, "Получили что-то на платформе.")

            dataReceive = data

             sink?.receive(SenderData.ReceiveData().apply {
                 this.data = dataReceive?.data
             }, ) {}


            return SenderData.SenderStatus().apply {
                resultSuccessful = true
                hasError = false
                error = null
            }

        } catch (platformError: Throwable ){
            return SenderData.SenderStatus().apply {
                resultSuccessful = false
                hasError = true
                error = platformError.message
            }
        }

    }
}