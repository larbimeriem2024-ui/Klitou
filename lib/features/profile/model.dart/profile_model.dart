


class Profile {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String avatar;

  const Profile({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id']  as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone:  json['phonen'] as String?,
      avatar: json['avatar'] as String,
    );
  }
}