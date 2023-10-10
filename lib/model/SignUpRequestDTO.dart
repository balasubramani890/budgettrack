class SignUpRequestDTO
{
  String? userName;
  String? mobileNo;
  String? password;

  SignUpRequestDTO({
    required this.userName,
    required this.mobileNo,
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'mobileNo': mobileNo,
      'password': password,
    };
  }

}