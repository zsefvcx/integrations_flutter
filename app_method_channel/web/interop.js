//use custom event emitter instead of browser native
//EventTarget because dart monkey patches this class.

class EventEmitter {
    constructor(){
        this._storage = new Map();
    }

    addEventListener(type, handler){
        if(this._storage.has(type)){
            this._storage.has(type).push(handler);
        } else {
            this._storage.set(type, [handler]);
        }
    }

    removeEventListener(type, handler){
        if(this._storage.has(type)){
            this._storage.set(type, this._storage.get(type).filter((fn)=> fn != handler));
            return true;
        }

        return false;
    }

     dispatchEvent(event){
            if(this._storage.has(event.type)){
                this._storage.get(event.type).forEach(handler => handler(event));
                return true;
            }

            return false;
     }
}

class JsInteropManager extends EventEmitter{



    constructor(){
        super();

        this.buttonElement = document.createElement('button');
        this.buttonElement.innerText = 'Web Native Button';

        window.addEventListener('click', (e) => {
            if(e.target === this.buttonElement)
            {
                const interopEvent = new JsInteropEvent('From Web');
                this.dispatchEvent(interopEvent);
            }
        })
        window._clickManager = this;
    }

    sendValueToStreamJs(arg){
        const interopEvent = new JsInteropEvent(arg);
        this.dispatchEvent(interopEvent);
        //alert("Hello From Web " + arg);
    }

    getValueFromJs(arg) {
        return arg;
    }
}

window.JsInteropManager = JsInteropManager;

class JsInteropEvent {
    constructor(value) {
        this.type = 'InteropEvent';
        this.value = value;
    }
}

window.JsInteropEvent = JsInteropEvent;

//window.ClicksNamespace = {
//    JsInteropManager,
//    JsInteropEvent,
//}