// ignore_for_file: unused_local_variable, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_app/Controller/addlink_controller.dart';
import 'package:webview_app/Model/add_link_model.dart';
import 'package:webview_app/View/WebViewController.dart';
import 'package:webview_app/View/defualt_screen.dart';
import 'package:webview_app/Widgets/my_input_field.dart';
import 'package:webview_app/constants/color.dart';
import 'package:webview_app/constants/size_config.dart';
import 'package:webview_app/localDB/local_DB.dart';

enum ButtonState { init, loading, done }

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final _urlController = TextEditingController();
  final AddLinkController addLinkController = Get.put(AddLinkController());
  var storage = GetStorage();

  Future<void> _navigateToWebViewScreen() async {
    final url = _urlController.text;
    print("WebView Url is :$url");
    final prefs = await SharedPreferences.getInstance();
     var webUrl = await prefs.setString('weburl', url);
        print("DeviceToken is shared : $webUrl");

    Get.to(() => WebViewScreen(url: url));
  }

  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    bool isStretched = isAnimating || state == ButtonState.init;
    bool isDone = state == ButtonState.done;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        title: const Text('WebView Application'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: AppConfig(context).height / 2,
                  width: AppConfig(context).height / 2,
                  child: Lottie.asset(
                    "assets/images/pic3.json",
                  ),
                ),
              ),
              MyInputField(
                obscureText: false,
                isPass: false,
                keyboardType: TextInputType.url,
                controller: _urlController,
                autofillHints: const [AutofillHints.url],
                height: 2.5 * kDefaultPadding,
                width: 18 * kDefaultPadding,
                labelText: 'Enter a URL',
                // suffixIcon: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please add Email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: height * 0.08,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  width: state == ButtonState.init ? width : 60,
                  height: 60,
                  onEnd: () => setState(() => isAnimating = !isAnimating),
                  child: isStretched ? buildbutton() : buildSmallButton(isDone),
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              // TextButton(
              //     onPressed: () {
              //       Get.to(() => const DefaultScreen());
              //     },
              //     child: const Text('Next Page'))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildbutton() => OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: const BorderSide(width: 2, color: white)),
      onPressed: () async {
        setState(() => state = ButtonState.loading);
        await Future.delayed(const Duration(seconds: 3));
        setState(() => state = ButtonState.done);
        await Future.delayed(const Duration(seconds: 3), () {
          // final url = _urlController.text.trim();
          // final AddLinkController addLinkController =
          //     Get.put(AddLinkController());
          // AddLinkModel? addlinkmodel = AddLinkModel(
          //   url: url,
          // );
          // addLinkController.addReportMethod(
          //     addLinkModel: addlinkmodel, tableName: DBHelper.addLinkTable);
          _navigateToWebViewScreen();
        });

        setState(() => state = ButtonState.init);
        await Future.delayed(const Duration(seconds: 3));
      },
      child: const FittedBox(
        child: Text(
          'Generate View',
          style: TextStyle(
              color: white,
              fontSize: 20,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600),
        ),
      ));

  Widget buildSmallButton(bool isDone) {
    final color = isDone ? green : backgroundColor;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: isDone
            ? const Icon(Icons.done, size: 52, color: white)
            : const CircularProgressIndicator(color: white),
      ),
    );
  }
}
