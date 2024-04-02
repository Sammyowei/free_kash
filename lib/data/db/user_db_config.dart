import 'package:firebase_core/firebase_core.dart';
import 'package:free_kash/data/db/_db_config.dart';
import 'package:free_kash/data/models/user/user.dart';

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
    }
  }
}
