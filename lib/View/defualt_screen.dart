import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_app/Controller/addlink_controller.dart';
import 'package:webview_app/constants/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  final AddLinkController addLinkController = Get.put(AddLinkController());
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    loadWebUrl();
  }

  Future<void> loadWebUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final webUrl = prefs.getString('weburl') ?? '';
    print("DeviceID is: $webUrl");
    setState(() {
      _webUrl = webUrl;
    });
  }

  String? _webUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("WebView APP"),
      ),
      body: _webUrl != null
          ? WebView(
              initialUrl: _webUrl!,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
