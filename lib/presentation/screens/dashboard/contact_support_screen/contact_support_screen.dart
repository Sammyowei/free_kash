import 'package:flutter/material.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  late WebViewController _controller;

  @override
  void didChangeDependencies() {
    final ref = ProviderScope.containerOf(context);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('Started Loading');

            ref.read(loadingProvider.notifier).toggleOn();
          },
          onPageStarted: (String url) {
            print('Page Started');
          },
          onPageFinished: (String url) {
            print('Page Finished');

            ref.read(loadingProvider.notifier).toggleOff();
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
        Uri.parse('https://tawk.to/chat/6617c60f1ec1082f04e13691/1hr6drbjk'),
      );

    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   final ref = ProviderScope.containerOf(context);
  //   _controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(const Color(0x00000000))
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           print('Started Loading');

  //           ref.read(loadingProvider.notifier).toggleOn();
  //         },
  //         onPageStarted: (String url) {
  //           print('Page Started');
  //         },
  //         onPageFinished: (String url) {
  //           print('Page Finished');

  //           ref.read(loadingProvider.notifier).toggleOff();
  //         },
  //         onWebResourceError: (WebResourceError error) {},
  //       ),
  //     )
  //     ..loadRequest(
  //       Uri.parse('https://tawk.to/chat/6617c60f1ec1082f04e13691/1hr6drbjk'),
  //     );

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.background,
        appBar: AppBar(
          backgroundColor: Palette.background,
          title: ReadexProText(
            data: 'Support',
            color: Palette.text,
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final isLoading = ref.watch(loadingProvider);
            return isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Palette.primary,
                    ),
                  )
                : WebViewWidget(controller: _controller);
          },
        ));
  }
}
