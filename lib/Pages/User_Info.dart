import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserInfoList extends StatefulWidget {
  const UserInfoList({Key? key}) : super(key: key);

  @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  Future<List<dynamic>> getUserInfo() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    return jsonDecode(response.body);
  }

  void customToasMessage() {
    Fluttertoast.showToast(
        msg: "Hello",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: asyncSnapshot.data.length,
                  itemBuilder: (context, int position) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                              asyncSnapshot.data[position]["id"].toString()),
                        ),
                        title: GestureDetector(
                          child: Text(
                              asyncSnapshot.data[position]["title"].toString()),
                          onTap: () {
                            customToasMessage();
                          },
                        ),
                        subtitle: Text(
                            asyncSnapshot.data[position]["body"].toString()),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
