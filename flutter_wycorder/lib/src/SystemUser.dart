// SystemUser.dart 
// Class for SystemUser

class SystemUser {

  int system_user_id;
  String email;
  String sis_id;
  String token;
  String password;
  int active;
  DateTime created_at;

  // Constructor
  SystemUser({
    this.system_user_id,
    this.email,
    this.sis_id,
    this.token,
    this.password,
    this.active,
    this.created_at
  });

  // JSON Factory
  factory SystemUser.fromJson(Map<String, dynamic> json) {
    return SystemUser(
      system_user_id:json['system_user_id'],
      email:json['email'],
      sis_id:json['sis_id'],
      token:json['token'],
      password:json['password'],
      active:json['active'],
      created_at:json['created_at']
    );
  }


}