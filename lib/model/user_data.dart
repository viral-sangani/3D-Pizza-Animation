class UserData {
  UserData(
      {required this.name,
      required this.phoneNumber,
      this.email,
      required this.address});

  final String name;
  final String phoneNumber;
  final String? email;
  final String address;

  UserData.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          phoneNumber: json['phoneNumber']! as String,
          address: json['address']! as String,
          email: (json['email'] != null ? (json['email']! as String) : ''),
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email ?? '',
    };
  }

  @override
  String toString() {
    return 'name: $name, phoneNumber: $phoneNumber, address: $address, email: $email';
  }
}
