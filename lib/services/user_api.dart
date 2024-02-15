import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/model/user_model.dart';
import '../model/user_name.dart';

class UserApi{
  static Future<List<User>> fetchUser() async{
    const url='https://randomuser.me/api/?results=50';
    final uri=Uri.parse(url);
    final response = await http.get(uri);
    final body=response.body;
    final json=jsonDecode(body);
    final result=json['results'] as List<dynamic>;
    final users=result.map((e){

      return User.fromMap(e);
    }).toList();
  return users;

  }
}