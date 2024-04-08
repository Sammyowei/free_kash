import 'package:animated_loading_indicators/animated_loading_indicators.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/db/user_db_config.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:free_kash/presentation/routes/routes.dart';
import 'package:free_kash/presentation/screens/dashboard/home_screen/home_screen.dart';
import 'package:free_kash/presentation/screens/dashboard/reward_screen/reward_screen.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:free_kash/presentation/widgets/widgets.dart';
import 'package:free_kash/provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late Stream<DatabaseEvent> _stream;

  @override
  void initState() {
    final UserDbConfig config = UserDbConfig();

    _stream = config.openConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircleAnimation(
                numberOfCircles: 10,
                duration: const Duration(milliseconds: 20),
                size: 5,
                circleRadius: 10,
                color: Palette.primary,
              ),
            );
          } else if (snapshot.hasError) {
            context.goNamed(RouteName.authGateway);

            return const Center(
              child: ReadexProText(data: 'An Error Occured'),
            );
          } else {
            final value =
                snapshot.data?.snapshot.value as Map<dynamic, dynamic>;
            final user = User.fromDynamicData(value);
            return Consumer(
              builder: (context, ref, child) {
                final index = ref.watch(dashboardPageNotifierProvider);
                final _screens = [
                  HomeScreen(
                    user: user,
                  ),
                  RewardScreen(user: user),
                  HomeScreen(
                    user: user,
                  ),
                  RewardScreen(user: user)
                ];
                return _screens[index];
              },
            );
          }
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(dashboardPageNotifierProvider);
          return BottomNavigationBar(
            selectedItemColor: Palette.primary,
            unselectedItemColor: Palette.secondary.withOpacity(0.8),
            showUnselectedLabels: true,
            unselectedLabelStyle: GoogleFonts.readexPro(
              fontSize: 12.sp,
            ),
            selectedLabelStyle: GoogleFonts.readexPro(
              fontSize: 12.sp,
            ),
            currentIndex: index,
            onTap: (value) {
              ref.read(dashboardPageNotifierProvider.notifier).moveTo(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.money_outlined),
                label: 'Earn',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
