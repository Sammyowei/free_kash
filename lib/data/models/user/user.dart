// ignore_for_file: avoid_init_to_null, no_leading_underscores_for_local_identifiers

import '../models.dart'; // Importing models.dart file which contains necessary classes/interfaces

class User {
  // A class representing a user

  User({
    this.firstName = null, // The first name of the user
    this.lastName = null, // The last name of the user
    this.middleName = null, // The middle name of the user (optional)
    this.emailAddress = null, // The email address of the user
    this.referralCode = null, // The referral code of the user
    this.isReferred = false, // Indicates whether the user was referred
    this.mobileNumber = null, // The mobile number of the user
    this.wallet = null, // The wallet of the user
    this.credentials = null, // The credentials of the user (optional)
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

  String? firstName; // The first name of the user
  String? lastName; // The last name of the user
  String? middleName; // The middle name of the user (optional)
  String? emailAddress; // The email address of the user
  String? referralCode; // The referral code of the user
  bool isReferred; // Indicates whether the user was referred
  String? mobileNumber; // The mobile number of the user

  Wallet? wallet; // The wallet of the user
  Credentials? credentials; // The credentials of the user (optional)
  List<Reward> rewardHistory; // The reward history of the user
  List<Withdrawal> withdrawalHistory; // The withdrawal history of the user

  DateTime? createdAt; // The creation timestamp of the user
  DateTime? updatedAt; // The last update timestamp of the user

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
      'wallet': wallet?.toJson(),
      'credentials': credentials?.toJson(),
      'reward_history': rewardHistory.map((reward) => reward.toJson()).toList(),
      'withdrawal_history':
          withdrawalHistory.map((withdrawal) => withdrawal.toJson()).toList(),
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }

  void addReward(double amount) {
    wallet?.addToBalance(amount);
    print(wallet?.walletBalance);
  }

  void addRewardToHistory(Reward reward) {
    rewardHistory.add(reward);

    print(rewardHistory);
  }

  void withdraw(double amount) {
    wallet?.withdrawFromBalance(amount);
  }

  void addToWithdrawalHistory(Withdrawal withdrawal) {
    withdrawalHistory.add(withdrawal);
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

  factory User.fromDynamicData(Map data) {
    var decodedValue = data;
    final wallet = decodedValue['wallet'] as Map;

    final withdrawals = decodedValue['withdrawal_history'] as List<dynamic>?;
    final rewards = decodedValue['reward_history'] as List<dynamic>?;

    List<Reward> _rewardHistory = [];
    List<Withdrawal> _withdrawalHistory = [];

    if (rewards != null) {
      if (rewards.isEmpty) {
        _rewardHistory = [];
      } else {
        for (var reward in rewards) {
          final _reward = Reward(
              amount: double.parse(reward['amount'].toString()),
              createdAt: DateTime.parse(reward['created_at']),
              description: reward['description'],
              uuid: reward['uuid']);

          _rewardHistory.add(_reward);
        }
      }
    }

    if (withdrawals != null) {
      if (withdrawals.isEmpty) {
        _withdrawalHistory = [];
      } else {
        for (var withdwaral in withdrawals!) {
          final _credential = withdwaral['credential'];
          final _withdrawal = Withdrawal(
            accountId: withdwaral['account_id'],
            amount: double.parse(withdwaral['amount'].toString()),
            createdAt: DateTime.parse(withdwaral['created_at']),
            status: withdwaral['status'],
            description: withdwaral['description'],
            credentials: Credentials(
              accountName: _credential['account_name'],
              accountNumber: _credential['account_number'],
              bankName: _credential['bank_name'],
            ),
            uuid: withdwaral['uuid'],
          );

          _withdrawalHistory.add(_withdrawal);
        }
      }
    }

    final credentials = decodedValue['credentials'] as Map;
    return User(
      emailAddress: decodedValue['email_address'],
      wallet: Wallet(
        walletBalance: double.parse(wallet['wallet_balance'].toString()),
      ),
      updatedAt: DateTime.parse(decodedValue['updated_at']),
      credentials: Credentials(
        accountName: credentials['account_name'],
        accountNumber: credentials['account_number'],
        bankName: credentials['bank_name'],
      ),
      referralCode: decodedValue['referral_code'],
      isReferred: decodedValue['is_referred'],
      createdAt: DateTime.parse(
        decodedValue['created_at'],
      ),
      lastName: decodedValue['last_name'],
      middleName: decodedValue['middle_name'],
      mobileNumber: decodedValue['mobile_number'],
      firstName: decodedValue['first_name'],
      rewardHistory: _rewardHistory,
      withdrawalHistory: _withdrawalHistory,
    );
  }

  void addUserDetails({
    required String mobileNumbers,
    required String firstNames,
    required String lastNames,
    String? middleNames,
  }) {
    firstName = firstNames;
    lastName = lastNames;
    middleName = middleNames;
    mobileNumber = mobileNumbers;
  }

  void addEmail(String email) {
    emailAddress = email;
  }

  void addCredentials(Credentials credential) {
    credentials = Credentials.copyWith(credential);
  }

  // Static method to create a copy of a User object
  static User copyWith(User user) {
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
