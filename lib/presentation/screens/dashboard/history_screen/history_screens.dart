import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:free_kash/presentation/presentations.dart';
import 'package:free_kash/presentation/screens/dashboard/home_screen/home_screen.dart';
import 'package:free_kash/presentation/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../data/data.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.user});

  final User user;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only().w,
      child: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          return Column(
            children: [
              TabBar(
                controller: _controller,
                labelColor: Palette.primary,
                indicatorColor: Palette.primary,
                unselectedLabelColor: Palette.secondary,
                tabs: const [
                  Tab(
                    text: 'Reward Earnings',
                  ),
                  Tab(
                    text: 'Withdrawal History',
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.82,
                width: MediaQuery.sizeOf(context).width,
                child: TabBarView(
                  controller: _controller,
                  children: [
                    TotalEarning(
                      rewards: widget.user.rewardHistory,
                    ),
                    TotalWithdrawal(
                      withdrawals: widget.user.withdrawalHistory,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}

class TotalEarning extends StatelessWidget {
  const TotalEarning({super.key, required this.rewards});

  final List<Reward> rewards;

  @override
  Widget build(BuildContext context) {
    if (rewards.isNotEmpty) {
      return ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 15, right: 15).w,
            child: RewardContainer(
              reward: rewards[index],
            ),
          );
        },
      );
    }
    return const Center(
      child: ReadexProText(data: 'Oops, nothing to see here.'),
    );
  }
}

class TotalWithdrawal extends StatelessWidget {
  const TotalWithdrawal({super.key, required this.withdrawals});

  final List<Withdrawal> withdrawals;

  @override
  Widget build(BuildContext context) {
    if (withdrawals.isNotEmpty) {
      return ListView.builder(
        itemCount: withdrawals.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 15, right: 15).w,
            child: WithdrawalContainer(
              withdrawal: withdrawals[index],
            ),
          );
        },
      );
    }
    return const Center(
      child: ReadexProText(data: 'Oops, nothing to see here.'),
    );
  }
}

class WithdrawalContainer extends StatelessWidget {
  const WithdrawalContainer({
    super.key,
    required this.withdrawal,
  });

  final Withdrawal withdrawal;

  String formatedAmount(double amount) {
    final formatCurrency = NumberFormat.currency(
      name: 'FreeKash Points',
      symbol: '₣',
    );

    return formatCurrency.format(amount);
  }

  String formatedDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final amount = formatedAmount(withdrawal.amount);

    final date = formatedDate(withdrawal.createdAt);
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10).w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10).r,
        ),
        color: Palette.surface,
        shadows: const [BoxShadow()],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadexProText(
                data: withdrawal.description,
                fontSize: 16.sp,
                color: Palette.text,
              ),
              ReadexProText(
                data: date,
                color: Palette.secondary.withOpacity(0.8),
                fontSize: 12.sp,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ReadexProText(
                data: '+$amount',
                fontSize: 16.sp,
                color: Palette.green,
                fontWeight: FontWeight.w500,
              ),
              ReadexProText(
                data: '+${withdrawal.status}',
                fontSize: 14.sp,
                color: Palette.green,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
