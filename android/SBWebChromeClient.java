package biz.zentooo;

import android.webkit.WebView;
import android.webkit.WebChromeClient;
import android.webkit.JsPromptResult;

public abstract class SBWebChromeClient extends WebChromeClient {
    public abstract boolean onReceiveMessage(String source, String data);

    public boolean onJsPrompt(WebView view, String url, String message, String defaultValue, JsPromptResult result) {
        result.confirm("");
        return onReceiveMessage(url, message);
    }
}
