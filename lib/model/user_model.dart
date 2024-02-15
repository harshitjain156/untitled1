import 'package:untitled1/model/user_name.dart';

class User{
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final UserName userName;

  User({
    required this.email,required this.phone,required this.gender,required this.cell,required this.userName
});

  factory User.fromMap(Map<String,dynamic> e){
    final name =UserName(title: e['name']['title'], first: e['name']['first'], last: e['name']['last']);
    return User(email: e['email'], gender: e['gender'], cell: e['cell'], phone: e['phone'], userName: name);

  }


  String get fullName{return '${userName.title} ${userName.first} ${userName.last}';}
}

