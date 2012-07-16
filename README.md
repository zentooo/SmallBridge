# Interface

## for JavaScript
    SmallBridge.sendMesage("<string>");

    SmallBridge.addMessageListener(function(source, data) {
        console.log(source); // bundle ID as String
        console.log(data); // received data as String
    });

## for iOS
    -(void) sendMessage:(NSString *)data;

    // source is URL of loaded document
    -(BOOL)onReceiveMessage:(NSString*)source withData:(NSString*)data;

## for Android
    public void sendMessage(Context context, String data)

    // source is URL of loaded document
    public boolean onReceiveMessage(String source, String data)

# How to use

## on JavaScript

## on Android

## on iOS
