import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebViewController webViewController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          webViewController.goBack();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Flutter Webview App'),
          ),
          body: SafeArea(
            top: true,
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://www.harunayyildiz.com/',
              onWebViewCreated: (controller) {
                webViewController = controller;
                print("::: onWebViewCreated");
              },
              onPageStarted: (text) {
                print("::: onPageStarted");
              },
              onPageFinished: (text) {
                print("::: onPageFinished");
              },
              onWebResourceError: (error) {
                print("::: onWebResourceError");
              },
              navigationDelegate: (NavigationRequest request) {
                if (!request.url.contains('harunayyildiz')) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Text("Tarayıda aç?"),
                          actions: <Widget>[
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: Text("Hayır"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text("Evet"),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    if (await canLaunch(request.url)) {
                                      await launch(
                                        request.url,
                                        forceSafariVC: false,
                                        forceWebView: false,
                                        headers: <String, String>{
                                          'my_header_key': 'my_header_value'
                                        },
                                      );
                                    } else {
                                      throw 'Could not launch $request.url';
                                    }
                                  },
                                )
                              ],
                            )
                          ],
                        );
                      });
                  return NavigationDecision.prevent;
                } else {}
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
            ),
          ),
        ),
      ),
    );
  }
}
