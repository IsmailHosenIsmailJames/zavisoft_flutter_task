import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final String street;
  final String city;
  final int zipcode;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.street,
    required this.city,
    required this.zipcode,
  });

  String get fullName => '$firstName $lastName';

  String get fullAddress => '$street, $city, $zipcode';

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? {};
    final address = json['address'] ?? {};
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstName: name['firstname'] ?? '',
      lastName: name['lastname'] ?? '',
      phone: json['phone'] ?? '',
      street: address['street'] ?? '',
      city: address['city'] ?? '',
      zipcode: int.tryParse(address['zipcode']?.toString() ?? '') ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    firstName,
    lastName,
    phone,
    street,
    city,
    zipcode,
  ];
}
