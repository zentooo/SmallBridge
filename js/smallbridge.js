(function(win, doc) {
    'use strict';
    var SmallBridge = {},
        scheme = "smallbridge://",
        frame = doc.createElement("iframe"),
        defineProperty = Object.defineProperty || function(obj, key, desc) {
            obj.key = desc.value;
        },
        define = function(obj, key, value) {
            defineProperty(obj, key, {
                configurable: false,
                enumerable: false,
                writable: false,
                value: value
            });
        };

    define(SmallBridge, "setPlatform", function(platform) {
        if ( platform === "ios" ) { // with iOS
            define(SmallBridge, "sendMessage", function(data) {
                frame.src = scheme + data;
                doc.body.appendChild(frame);
                doc.body.removeChild(frame);
            });
        }
        else if ( platform === "android" ) { // with Android
            define(SmallBridge, "sendMessage", function(data) {
                win.prompt(data);
            });
        }
    });

    define(SmallBridge, "addMessageListener", function(listener) {
        define(SmallBridge, "_listener", listener);
    });

    define(SmallBridge, "messageCallback", function(source, data) {
        SmallBridge._listener(source, data);
    });

    define(win, "SmallBridge", SmallBridge);
})(this, document);
