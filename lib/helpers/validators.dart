class Validators{

  ///Valid email
  static bool email(String email) =>  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  ///Valid password
  static bool password(String password) =>  password.length>=6;





}