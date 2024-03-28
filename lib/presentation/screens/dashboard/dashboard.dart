import 'package:flutter/material.dart';
import 'package:free_kash/presentation/presentations.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ReadexProText(
          data: 'Home Page',
        ),
      ),
    );
  }
}
