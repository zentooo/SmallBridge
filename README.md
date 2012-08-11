# Interface

## for JavaScript / iOS
## JavaScript side
    // just send a messaget to native layer
    SmallBridge.sendMesage("bookmark1", { url: "http://example.com", title: "example" });

    // send a messaget with result callback
    SmallBridge.sendMesage("bookmark2", { url: "http://example.com", title: "example" }, function(err, data) { });

## iOS side
    // add message listener with Block
    [self addMessageListener:@"bookmark1" callback:^(NSString *sourceURL, NSDictionary *data, SBResult *result) {
    }];

    // add message listener with delegation
    [self addMessageListener:@"bookmark2" target:self selector:@selector(onBookmark:data:result:)];

## for Android
