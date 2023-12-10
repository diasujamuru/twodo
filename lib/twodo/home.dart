import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twodo/twodo/input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _notedata = [];
  Future _getNote() async {
    try {
      final response = await http.get(
          Uri.parse("https://6571a4bad61ba6fcc01328ac.mockapi.io/to_do_list"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _notedata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _delete(String id) async {
    try {
      final response = await http.delete(
          Uri.parse(
              "https://6571a4bad61ba6fcc01328ac.mockapi.io/to_do_list/" + id),
          body: {"id": id});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(onPressed: () {}, child: Text("Delete Data"));
    AlertDialog alertDialog = AlertDialog(
      title: Text("Confirm Delete Data"),
      content: Text("Are you sure to delete this data ?"),
      actions: [okButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void initState() {
    _getNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your 2Dos")),
      body: ListView.builder(
          itemCount: _notedata.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 5.0, 45.0, 5.0),
              child: Card(
                child: InkWell(
                  child: ListTile(
                    leading: Icon(Icons.task_outlined, color: Colors.teal),
                    title: Text(
                      _notedata[index]['kegiatan'],
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                    trailing: Wrap(
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content:
                                          Text("Is this task already clear ?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              bool response = await _delete(
                                                  _notedata[index]['id']);
                                              if (response) {
                                                print("Data berhasil dihapus");
                                              } else { 
                                                print("Data gagal di hapus");
                                              }
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()),
                                                  (route) => false);
                                            },
                                            child: Text("Yes")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No"))
                                      ],
                                    );
                                  }));
                            },
                            icon: Icon(
                              Icons.check_box_outlined,
                              color: Colors.teal,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InputPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
