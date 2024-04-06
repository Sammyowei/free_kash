import 'package:free_kash/provider/state_notifiers/int_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final onboardingIndexProvider = StateNotifierProvider<IntNotifier, int>((ref) {
  return IntNotifier();
});
