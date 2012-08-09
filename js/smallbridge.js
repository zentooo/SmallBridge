(function(win, doc) {
    'use strict';

    var SmallBridge = {},
        baseUri = "smallbridge://",
        frame = doc.createElement("iframe"),
        callbacks = {};

    var defineProperty = Object.defineProperty || function(obj, key, desc) {
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

    function registerCallback(type, callback) {
        var id;
        if ( ! callbacks[type] ) {
            callbacks[type] = [];
            callbacks[type].id = 0;
        }
        id = callbacks[type].id++;
        callbacks[type][id] = callback;
        return id;
    }

    define(SmallBridge, "setPlatform", function(platform) {
        if ( platform === "ios" ) { // with iOS
            define(SmallBridge, "sendMessage", function(type, data, callback) {
                var callbackId;
                if ( typeof callback === "function" ) {
                    callbackId = registerCallback(type, callback);
                }

                frame.src = baseUri + JSON.stringify({
                    type: type,
                    data: data,
                    callbackId: callbackId
                });
                doc.body.appendChild(frame);
                doc.body.removeChild(frame);
            });
        }
        else if ( platform === "android" ) { // with Android
            define(SmallBridge, "sendMessage", function(type, data, callback) {
                var callbackId;
                if ( typeof callback === "function" ) {
                    callbackId = registerCallback(type, callback);
                }

                win.prompt(JSON.stringify({
                    type: type,
                    data: data,
                    callbackId: callbackId
                }));
            });
        }
    });

    define(SmallBridge, "_receive", function(type, id, error, result) {
        callbacks[type][id](error, result);
        delete callbacks[type][id];
    });

    define(win, "SmallBridge", SmallBridge);
})(this, document);
