import 'dart:ffi';

class Login {
  const Login({
    required this.id,
    required this.email,
    required this.token,
    required this.name,
    required this.tenantId,
    required this.company,
  });

  final String id;
  final String token;
  final String email;
  final String name;
  final String tenantId;
  final String company;

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['data']['user']['_id'],
      email: json['data']['user']['email'],
      token: json['data']['token'],
      name: json['data']['user']['firstName'],
      tenantId: json['data']['listCompany'][0]['tenant'],
      company: json['data']['listCompany'][0]['_id'],
    );
  }
}
