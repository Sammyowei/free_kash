class Wallet {
  // A class representing a user's wallet

  // Constructor for Wallet class
  Wallet({
    required this.totalWithdrawal, // The total amount withdrawn from the wallet
    required this.walletBalance, // The current balance of the wallet
  });

  // Properties of Wallet class
  double walletBalance; // The current balance of the wallet
  double totalWithdrawal; // The total amount withdrawn from the wallet

  // Method to create a copy of a Wallet object
  static Wallet copyWith(Wallet newWallet) {
    return Wallet(
      totalWithdrawal: newWallet.totalWithdrawal,
      walletBalance: newWallet.walletBalance,
    );
  }

  // Factory method to create a Wallet object from JSON data
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      totalWithdrawal:
          json['total_withdrawal'], // Parsing total withdrawal from JSON
      walletBalance: json['wallet_balance'], // Parsing wallet balance from JSON
    );
  }

  // Method to convert Wallet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'total_withdrawal': totalWithdrawal,
      'wallet_balance': walletBalance,
    };
  }

  // Method to add an amount to the total withdrawal
  void addToWithdrawal(double amount) {
    totalWithdrawal += amount;
  }

  // Method to add an amount to the wallet balance
  void addToBalance(double amount) {
    walletBalance += amount;
  }
}
