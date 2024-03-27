class Credentials {
  // A class representing credentials for a bank account

  // Constructor for Credentials class
  const Credentials({
    required this.accountName, // The name associated with the bank account
    required this.accountNumber, // The account number of the bank account
    required this.bankName, // The name of the bank
  });

  // Properties of Credentials class
  final String accountNumber; // The account number of the bank account
  final String accountName; // The name associated with the bank account
  final String bankName; // The name of the bank

  // Factory method to create Credentials object from JSON data
  factory Credentials.fromJson(Map<String, dynamic> json) {
    return Credentials(
      accountName: json['account_name'], // Parsing account name from JSON
      accountNumber: json['account_number'], // Parsing account number from JSON
      bankName: json['bank_name'], // Parsing bank name from JSON
    );
  }

  // Method to create a copy of a Credentials object
  static Credentials copyWith(Credentials credentials) {
    return Credentials(
      accountName: credentials.accountName,
      accountNumber: credentials.accountNumber,
      bankName: credentials.bankName,
    );
  }

  // Method to convert Credentials object to JSON
  Map<String, dynamic> toJson() {
    return {
      'account_name': accountName,
      'account_number': accountNumber,
      'bank_name': bankName,
    };
  }
}
