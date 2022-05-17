class User {
  const User({
    required this.id,
    required this.email,
    required this.employeeId,
  });

  final String id;
  final String email;
  final String employeeId;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['employee']['_id'],
      email: json['data']['email'],
      employeeId: json['data']['employee']['employeeId'],
    );
  }
}
