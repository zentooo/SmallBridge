package biz.zentooo;

import android.content.Context;
import android.util.AttributeSet;
import android.webkit.WebView;

public class SBWebView extends WebView {
    public SBWebView(Context context) {
        super(context);
        this.setWebViewClient(new SBWebViewClient());
    }
    public SBWebView(Context context, AttributeSet attrs) {
        super(context, attrs);
        this.setWebViewClient(new SBWebViewClient());
    }
    public SBWebView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        this.setWebViewClient(new SBWebViewClient());
    }

    public void sendMessage(Context context, String data) {
        String source = context.getPackageName();
        this.loadUrl(String.format("javascript:SmallBridge.messageCallback(\"%s\", \"%s\")", source, data));
    }
}
