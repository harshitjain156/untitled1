import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/services/user_api.dart';

import '../model/user_model.dart';
import '../model/user_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get API"),),
      body: ListView.builder(itemCount: users.length,itemBuilder: (context,index){
        final user=users[index];
        final image='https://randomuser.me/api/portraits/thumb/men/0.jpg';
        return ListTile(title: Text(user.fullName),subtitle: Text(user.email.toString()),leading: CircleAvatar(child: Text('$index')),);
      }),

    );
  }

  Future<void> fetchUser() async{
    final response=await UserApi.fetchUser();
    setState(() {
      users=response;
    });
  }

  // Future<void> fetchUser() async{
  //   const url='https://randomuser.me/api/?results=50';
  //   final uri=Uri.parse(url);
  //   final response = await http.get(uri);
  //   final body=response.body;
  //   final json=jsonDecode(body);
  //   final result=json['results'] as List<dynamic>;
  //   final transformed=result.map((e){
  //
  //     final name =UserName(title: e['name']['title'], first: e['name']['first'], last: e['name']['last']);
  //     return User(email: e['email'], gender: e['gender'], cell: e['cell'], phone: e['phone'], userName: name);
  //   }).toList();
  //   setState(() {
  //     users=transformed;
  //   });
  //
  //   print("API Called");
  // }
}
