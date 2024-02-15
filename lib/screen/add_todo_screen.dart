import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  final Map? todo;
  const AddTodoScreen({Key? key,this.todo}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController desController=TextEditingController();
  bool isEdit=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo=widget.todo;
    if(todo!=null){
      isEdit=true;
      final title=todo['title'];
      final description=todo['description'];
      titleController.text=title;
      desController.text=description;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit?"Edit Todo":"Add todo"),),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: desController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: isEdit?updateData:submitData, child: Text(isEdit?'Update':'Submit'))
        ],
      ),
    );
  }

  Future<void> submitData() async{
    final title=titleController.text;
    final description=desController.text;
    final body={
      'title':title,
      'description':description,
      'is_completed':false
    };

    final url='https://api.nstack.in/v1/todos';
    final uri=Uri.parse(url);
    final response=await http.post(uri,body: jsonEncode(body),headers: {
      'Content-Type':'application/json'
    });
    print(response.statusCode);
    showSuccessMessage(response.body);
    if(response.statusCode==200 || response.statusCode==201 ){
      Navigator.pop(context);

    }


  }


  Future<void> updateData() async{
    final todo=widget.todo;
    if(todo==null){
      return;
    }
    final id=todo['_id'];
    final title=titleController.text;
    final description=desController.text;
    final body={
      'title':title,
      'description':description,
      'is_completed':false
    };

    final url='https://api.nstack.in/v1/todos/${id}';
    final uri=Uri.parse(url);
    final response=await http.put(uri,body: jsonEncode(body),headers: {
      'Content-Type':'application/json'
    });
    print(response.statusCode);
    showSuccessMessage(response.body);
    if(response.statusCode==200){
      Navigator.pop(context);

    }

  }


  void showSuccessMessage(String message){
    final snackBar=SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
