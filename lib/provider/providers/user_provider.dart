import 'package:free_kash/data/models/user/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = Provider<User>((ref) {
  return User();
});

final userDataProvider = Provider.family<User, User>((ref, user) {
  return user;
});
