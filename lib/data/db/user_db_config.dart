// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:free_kash/data/auth/auth.dart';
import 'package:free_kash/data/data.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/data/models/user/user.dart';
import 'package:uuid/uuid.dart';

/// A class for configuring database interactions for user data.
class UserDbConfig extends DbConfig {
  /// Constructor for [UserDbConfig].
  UserDbConfig() : super(dbStore: 'users');

  /// Adds a user to the database.
  /// [user]: The user object to add.
  /// [path]: The path where the user data should be stored.
  Future<Map<String, dynamic>> addUser(User user, String path) async {
    try {
      await create(user.toJson(),
          path); // Convert user object to JSON and create in the database
      return {"message": 'Data added successfully.'}; // Return success message
    } on FirebaseException catch (error) {
      // If an error occurs during Firebase operation, catch and handle it
      print(
          'Error occurred while adding user: ${error.message}'); // Log the error message for debugging
      return {
        "error": 'An error occurred while adding user.'
      }; // Return error message
    } catch (e) {
      return {
        "error": 'An error occurred while adding user.'
      }; // Catch-all for any other errors
    }
  }

  /// Updates user data in the database.
  /// [user]: The updated user object.
  /// [accountId]: The ID of the account to update.
  Future<Map<String, dynamic>> addReward(User user, String accountId) async {
    try {
      update(user.toJson(), accountId); // Update user data in the database
      return {
        "message": 'Data updated successfully.'
      }; // Return success message
    } on FirebaseException catch (error) {
      // If an error occurs during Firebase operation, catch and handle it
      print(
          'Error occurred while updating user data: ${error.message}'); // Log the error message for debugging
      return {
        "error": 'An error occurred while updating user data.'
      }; // Return error message
    } catch (e) {
      return {
        "error": 'An error occurred while updating user data.'
      }; // Catch-all for any other errors
    }
  }

  Future<void> addReferalReward(String identifier) async {
    final refData = await read(identifier);

    if (refData.snapshot.exists) {
      final value = refData.snapshot.value;

      if (value != null) {
        final Map<dynamic, dynamic> _value =
            Map<dynamic, dynamic>.from(value as Map<Object?, Object?>);

        // convert to map<String dynamic>

        final Map<String, dynamic> decodedValue =
            Map<String, dynamic>.from(_value);

        final referee = User.fromDynamicData(decodedValue);

        const rewardPrice = 100.0;
        final reward = Reward(
          amount: rewardPrice,
          createdAt: DateTime.now(),
          description: "Referral Earning",
          uuid: const Uuid().v1(),
        );

        referee.addRewardToHistory(reward);
        referee.addReward(rewardPrice);

        await update(referee.toJson(), identifier);
      }
    }
  }

  Stream<DatabaseEvent> openConnection() {
    final id = AuthClient().userID;
    return connectToDb(id!);
  }
}

Map<String, dynamic>? convertObjectToMap(Object? obj) {
  if (obj is Map<String, dynamic>) {
    return obj;
  }
  return null; // or handle the case where obj is not a Map
}
