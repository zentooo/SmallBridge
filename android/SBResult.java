package biz.zentooo;

import android.webkit.WebView;

import org.json;


public abstract class SBResult {
    private WebView type;
    private String type;
    private int callbackId;

    public SBWebChromeClient(WebView webView, String type, int callbackId) {
        this.webView = webView;
        this.type = type;
        this.callbackId = callbackId;
    }

    public boolean provide(JsObj result) {
        String jsString = "SmallBridge.call()";

        this.webView.loadUrl("javascript:" + jsString);
    }
}
