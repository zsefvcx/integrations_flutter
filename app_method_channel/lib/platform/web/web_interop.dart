@JS()
library interop;

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_util';
import 'dart:ui' as ui;
import 'dart:html' as html;

@JS('JsInteropEvent')
class _JsInteropEvent {
  external String value;
}

@JS('JsInteropEventType')
class EventType {
  // ignore: non_constant_identifier_names
  external static String get InteropEvent;
}

typedef ClicksManagerEventListener = void Function(_JsInteropEvent event);

@JS('JsInteropManager')
class JsInteropManager {
  external factory JsInteropManager();

  external html.IFrameElement get buttonElement;

  external String getValueFromJs(String arg);

  external void sendValueToStreamJs(String arg);

  external void addEventListener(
     String event,
     ClicksManagerEventListener listener,
  );

  external void removeEventListener(
     String event,
     ClicksManagerEventListener listener,
  );

}

class _EventStreamProvider {
  final JsInteropManager _eventTarget;
  final List<StreamController<dynamic>> _controllers = [];

  _EventStreamProvider.forTarget(this._eventTarget);

  Stream<T> forEvent<T extends _JsInteropEvent>(String eventType){
    late StreamController<T> controller;
    void onEventReceived(event){
      controller.add(event as T);
    }

    final interopted = allowInterop(onEventReceived);

    controller = StreamController.broadcast(
      onCancel: () => _eventTarget.removeEventListener(
          eventType,
          interopted,
      ),
      onListen: () => _eventTarget.addEventListener(
          eventType,
          interopted
      ),
    );

    _controllers.add(controller);

    return controller.stream;
  }

}

class InteropManager {
  final _interop = JsInteropManager();
  late Stream<String> _streamEvent;

  InteropManager(){
    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'web-button',
        (viewId) => _interop.buttonElement,
    );

    final streamProvider = _EventStreamProvider.forTarget(_interop);
    _streamEvent = streamProvider.forEvent<_JsInteropEvent>(
      'InteropEvent'
    ).map((event) => event.value);
  }

  String getValueFromJs(String arg) {
    _interop.buttonElement.innerHtml = arg;
    return _interop.getValueFromJs(arg);
  }

  Stream<String> getStreamEvent(String arg) {
    return _streamEvent;
  }
  void toStream(String arg) {
    _interop.sendValueToStreamJs(arg);
    _interop.buttonElement.innerHtml = arg;
  }
}