import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled1/screen/add_todo_screen.dart';
import 'package:http/http.dart' as http;

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({Key? key}) : super(key: key);

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  List items=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
    print(items);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App'),),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView.builder(
            itemCount:items.length ,
            itemBuilder: (context,index){
          final item=items[index] as Map;
          final id=item['_id'] as String;
          print(item);
          return ListTile(
            title: Text(item['title']),
            leading: CircleAvatar(
              child: Text('${index+1}'),
            ),
            subtitle: Text('${item['description']}'),
            trailing: PopupMenuButton(
              onSelected: (value){
                if(value=='edit'){
                  navigateToEditPage(item);
                }else if(value=='delete'){
                    deleteById(id);
                }
              },
              itemBuilder: (context){
                return [
                  PopupMenuItem(child: Text('Edit'),
                  value: 'edit',),
                  PopupMenuItem(child: Text('Delete'),
                  value: 'delete',)
                ];
              },
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToAddPage,label: Text("Add todo"),),
    );
  }

  Future<void> navigateToAddPage() async{
    final route =MaterialPageRoute(builder: (context)=>AddTodoScreen());
    await Navigator.push(context, route);
    setState(() {

    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async{
    final route =MaterialPageRoute(builder: (context)=>AddTodoScreen(todo: item,));
    await Navigator.push(context, route);
    setState(() {

    });
    fetchTodo();
  }

  Future<void> fetchTodo() async{
    final url='https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    if(response.statusCode==200){
      final json=jsonDecode(response.body) as Map;
      final result=json['items'] as List;
      setState(() {
        items=result;
        print(response.statusCode);
        // print(result);
      });
    }
    else{

    }


  }

  Future<void> deleteById(String id) async {
final url='https://api.nstack.in/v1/todos/${id}';
final uri=Uri.parse(url);
final response= await http.delete(uri);
if(response.statusCode==200){
final filtered=items.where((element) => element['_id']!=id).toList();
setState(() {
  items=filtered;
});
}else{
    showSnackMessage(response.statusCode.toString());
}
     }
  void showSnackMessage(String message){
    final snackBar=SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
