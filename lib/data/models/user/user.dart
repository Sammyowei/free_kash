import '../models.dart'; // Importing models.dart file which contains necessary classes/interfaces

class User {
  // A class representing a user

  User({
    required this.firstName, // The first name of the user
    required this.lastName, // The last name of the user
    this.middleName, // The middle name of the user (optional)
    required this.emailAddress, // The email address of the user
    required this.referralCode, // The referral code of the user
    required this.isReferred, // Indicates whether the user was referred
    required this.mobileNumber, // The mobile number of the user
    required this.wallet, // The wallet of the user
    this.credentials, // The credentials of the user (optional)
    this.rewardHistory =
        const [], // The reward history of the user (default to empty list)
    this.withdrawalHistory =
        const [], // The withdrawal history of the user (default to empty list)
    DateTime? createdAt, // The creation timestamp of the user (optional)
    DateTime? updatedAt, // The last update timestamp of the user (optional)
  })  : createdAt = createdAt ??
            DateTime
                .now(), // If createdAt is null, set it to the current timestamp
        updatedAt = updatedAt ??
            DateTime
                .now(); // If updatedAt is null, set it to the current timestamp

  final String firstName; // The first name of the user
  final String lastName; // The last name of the user
  final String? middleName; // The middle name of the user (optional)
  final String emailAddress; // The email address of the user
  final String referralCode; // The referral code of the user
  final bool isReferred; // Indicates whether the user was referred
  final String mobileNumber; // The mobile number of the user

  final Wallet wallet; // The wallet of the user
  final Credentials? credentials; // The credentials of the user (optional)
  final List<Reward> rewardHistory; // The reward history of the user
  final List<Withdrawal>
      withdrawalHistory; // The withdrawal history of the user

  final DateTime createdAt; // The creation timestamp of the user
  final DateTime updatedAt; // The last update timestamp of the user

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'email_address': emailAddress,
      'referral_code': referralCode,
      'is_referred': isReferred,
      'mobile_number': mobileNumber,
      'wallet': wallet.toJson(),
      'credentials': credentials?.toJson(),
      'reward_history': rewardHistory.map((reward) => reward.toJson()).toList(),
      'withdrawal_history':
          withdrawalHistory.map((withdrawal) => withdrawal.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Factory method to create a User object from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      middleName: json['middle_name'],
      emailAddress: json['email_address'],
      referralCode: json['referral_code'],
      isReferred: json['is_referred'],
      mobileNumber: json['mobile_number'],
      wallet: Wallet.fromJson(json['wallet']),
      credentials: json['credentials'] != null
          ? Credentials.fromJson(
              json['credentials'],
            )
          : null,
      rewardHistory: (json['reward_history'] as List<dynamic>)
          .map((rewardJson) => Reward.fromJson(rewardJson))
          .toList(),
      withdrawalHistory: (json['withdrawal_history'] as List<dynamic>)
          .map((withdrawalJson) => Withdrawal.fromJson(withdrawalJson))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Static method to create a copy of a User object
  static User copyWith(
    User user, {
    String? firstName,
    String? lastName,
    String? middleName,
    String? emailAddress,
    String? referralCode,
    bool? isReferred,
    String? mobileNumber,
    Wallet? wallet,
    Credentials? credentials,
    List<Reward>? rewardHistory,
    List<Withdrawal>? withdrawalHistory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      firstName: user.firstName,
      lastName: user.lastName,
      middleName: user.middleName,
      emailAddress: user.emailAddress,
      referralCode: user.referralCode,
      isReferred: user.isReferred,
      mobileNumber: user.mobileNumber,
      wallet: user.wallet,
      credentials: user.credentials,
      rewardHistory: user.rewardHistory,
      withdrawalHistory: user.withdrawalHistory,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
}
