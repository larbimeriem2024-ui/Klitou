


class Profile {
  final int id;
  final String name;
  final String email;
  final String? phone;

  const Profile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id']  as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone:  json['phonen'] as String?,
    );
  }
}