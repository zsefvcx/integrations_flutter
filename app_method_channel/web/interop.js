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
                this._storage.set(event.type).foeEach(handler => handler(event));
                return true;
            }

            return false;
     }
}

class JsInteropManager extends EventEmitter{
    constructor(){
        super();


    }


}
