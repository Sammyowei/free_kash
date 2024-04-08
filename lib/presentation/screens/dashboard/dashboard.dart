import 'package:flutter/material.dart';

import 'package:free_kash/data/data.dart';
import 'package:free_kash/presentation/presentations.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ReadexProText(
              data: 'Home Page',
            ),
          ),
          TextButton(
            onPressed: () async => RewardedVideoAds()
              ..loadAds()
              ..showAds(),

            // onPressed: () => debugPrint(
            //     GoRouter.of(context).routeInformationProvider.value.uri.scheme),
            child: ReadexProText(data: 'Show ads'),
          )
        ],
      ),
    );
  }
}
