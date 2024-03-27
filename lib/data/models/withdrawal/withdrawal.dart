import '../models.dart'; // Importing models.dart file which contains necessary classes/interfaces

class Withdrawal {
  // A class representing a withdrawal transaction

  // Constructor for Withdrawal class
  const Withdrawal({
    required this.accountId, // The ID of the account from which withdrawal is made
    required this.amount, // The amount withdrawn
    required this.createdAt, // The timestamp when withdrawal was created
    required this.status, // The status of the withdrawal transaction
    required this.description, // The description of the withdrawal transaction
    required this.credentials, // The credentials used for withdrawal
    required this.uuid, // Universally unique identifier for the withdrawal
  });

  // Properties of Withdrawal class
  final String uuid; // Universally unique identifier for the withdrawal
  final double amount; // The amount withdrawn
  final DateTime createdAt; // The timestamp when withdrawal was created
  final String accountId; // The ID of the account from which withdrawal is made
  final String status; // The status of the withdrawal transaction
  final String description; // The description of the withdrawal transaction
  final Credentials credentials; // The credentials used for withdrawal

  // Method to create a copy of a Withdrawal object
  static Withdrawal copyWith(Withdrawal withdrawal) {
    return Withdrawal(
      accountId: withdrawal.accountId,
      description: withdrawal.description,
      status: withdrawal.status,
      amount: withdrawal.amount,
      createdAt: withdrawal.createdAt,
      credentials: withdrawal.credentials,
      uuid: withdrawal.uuid,
    );
  }

  // Factory method to create a Withdrawal object from JSON data
  factory Withdrawal.fromJson(Map<String, dynamic> json) {
    return Withdrawal(
      accountId: json['account_id'], // Parsing account ID from JSON
      amount: json['amount'], // Parsing amount from JSON
      createdAt: DateTime.parse(
          json['created_at']), // Parsing creation timestamp from JSON
      status: json['status'], // Parsing status from JSON
      description: json['description'], // Parsing description from JSON
      credentials: Credentials.fromJson(
          json['credential']), // Parsing credentials from JSON
      uuid: json['uuid'], // Parsing UUID from JSON
    );
  }

  // Method to convert Withdrawal object to JSON
  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'amount': amount,
      'uuid': uuid,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'description': description,
      'credential': credentials.toJson(),
    };
  }
}
