(function(win, doc) {
    'use strict';
    var SmallBridge = {},
        scheme = "smallbridge://",
        frame = doc.createElement("iframe"),
        defineProperty = Object.defineProperty || function(obj, key, desc) {
            obj.key = desc.value;
        };

    if ( true ) { // with iOS
        defineProperty(SmallBridge, "sendMessage", {
            configurable: false,
            enumerable: false,
            writable: false,
            value: function(data) {
                frame.src = scheme + data;
                doc.body.appendChild(frame);
                doc.body.removeChild(frame);
            }
        });
    }
    else { // with Android
        defineProperty(SmallBridge, "sendMessage", {
            configurable: false,
            enumerable: false,
            writable: false,
            value: function(data) {
                win.prompt(data);
            }
        });
    }

    defineProperty(SmallBridge, "addMessageListener", {
        configurable: false,
        enumerable: false,
        writable: false,
        value: function(listener) {
            defineProperty(SmallBridge, "_listener", {
                writable: false,
                value:  listener
            });
        }
    });

    defineProperty(SmallBridge, "messageCallback", {
        configurable: false,
        enumerable: false,
        writable: false,
        value: function(source, data) {
            SmallBridge._listener(source, data);
        }
    });

    defineProperty(win, "SmallBridge", {
        configurable: false,
        enumerable: false,
        writable: false,
        value: SmallBridge
    });
})(this, document);
