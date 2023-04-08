class Users {
  final String email;
  final String name;
  final String phone;
  final String address;
  Users({
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
  });

  Users copyWith({
    String? email,
    String? name,
    String? phone,
    String? address,
  }) {
    return Users(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }

  static Users fromMap(Map<String, dynamic> map) {
    return Users(
      email: map['email'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
    );
  }
}
