import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntNotifier extends StateNotifier<int> {
  IntNotifier() : super(0);

  void back() {
    state = state - 1;
  }

  void foward() {
    state = state + 1;
  }

  void moveTo(int index) {
    state = index;
  }
}
