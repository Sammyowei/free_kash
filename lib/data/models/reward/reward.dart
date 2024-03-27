class Reward {
  // A class representing a reward

  // Constructor for Reward class
  const Reward({
    required this.amount, // The amount of the reward
    required this.createdAt, // The timestamp when the reward was created
    required this.description, // The description of the reward
    required this.uuid, // Universally unique identifier for the reward
  });

  // Properties of Reward class
  final String uuid; // Universally unique identifier for the reward
  final double amount; // The amount of the reward
  final DateTime createdAt; // The timestamp when the reward was created
  final String description; // The description of the reward

  // Method to create a copy of a Reward object
  static Reward copyWith(Reward reward) {
    return Reward(
      amount: reward.amount,
      createdAt: reward.createdAt,
      description: reward.description,
      uuid: reward.uuid,
    );
  }

  // Factory method to create a Reward object from JSON data
  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      amount: json['amount'], // Parsing amount from JSON
      createdAt: DateTime.parse(
          json['created_at']), // Parsing creation timestamp from JSON
      description: json['description'], // Parsing description from JSON
      uuid: json['uuid'], // Parsing UUID from JSON
    );
  }

  // Method to convert Reward object to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
      'description': description,
      'uuid': uuid,
    };
  }
}
