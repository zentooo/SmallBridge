(function(win, doc) {
    var SmallBridge = {},
        scheme = "smallbridge://",
        frame = doc.createElement("iframe"),
        defineProperty = Object.defineProperty || function(obj, key, desc) {
            obj.key = desc.value;
        };

    if ( true ) { // with iOS
        SmallBridge.sendMessage = function(data) {
            frame.src = scheme + data;
            doc.body.appendChild(frame);
            doc.body.removeChild(frame);
        };
    }
    else { // with Android
        win.prompt(data);
    }

    defineProperty(SmallBridge, "_listeners", {
        writable: false,
        value: []
    });

    defineProperty(SmallBridge, "addMessageListener", {
        writable: false,
        value: function(listener) {
            SmallBridge._listeners.push(listener);
        }
    });

    defineProperty(SmallBridge, "messageCallback", {
        writable: false,
        value: function(source, data) {
            SmallBridge._listeners.forEach(function(listener) {
                listener.call(null, source, data);
            });
        }
    });

    if ( typeof Object.freeze === "function" ) {
        Object.freeze(SmallBridge);
    }

    win.SmallBridge = SmallBridge;
})(this, document);
