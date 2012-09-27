package biz.zentooo;

import android.webkit.WebView;
import android.webkit.WebChromeClient;
import android.webkit.JsPromptResult;

import org.json;


public abstract class SBWebChromeClient extends WebChromeClient {
    private HashMap<String, SBMessageListener> listeners;

    public SBWebChromeClient {
        super();
        this.listeners = new HashMap<String, SBMessageListener>();
    }

    public boolean onJsPrompt(WebView webView, String url, String message, String defaultValue, JsPromptResult result) {
        result.confirm("");

        JsObj jsObj = Json.parse(data);
        String type = jsObj.getString("type");
        JsObj data = jsObj.getString("data");
        int callbackid = jsObj.getInt("callbackId");

        SBResult result = new SBResult(webView, type, callbackId);

        return onReceiveMessage(url, type, data, result);
    }

    public boolean onReceiveMessage(String source, String type, JsObj data, SBResult result) {
        SBMessageListener listener = this.listeners.get(type)

        if ( listener != null ) {
            listener.onMessage(source, data, result);
        }
    }

    public void addMessageListener(String type, SBMessageListener listener) {
        this.listeners.add(type, listener)
    }
}
