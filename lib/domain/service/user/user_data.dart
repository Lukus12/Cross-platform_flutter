import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String userId;
  final String name;
  final String email;
  final String description;
  final Timestamp timestamp;

  UserData({
    required this.userId,
    required this.name,
    required this.email,
    required this.description,
    required this.timestamp,
  });

  // Метод для создания объекта UserData из JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  // Метод для преобразования объекта UserData в JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'description': description,
      'timestamp': timestamp,
    };
  }
}