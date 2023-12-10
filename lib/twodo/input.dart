import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twodo/twodo/home.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController kegiatan = TextEditingController();

  Future _save() async {
    final response = await http.post(
        Uri.parse("https://6571a4bad61ba6fcc01328ac.mockapi.io/to_do_list"),
        body: {'kegiatan': kegiatan.text});

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input")),
      body: Form(
        key: formKey,
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "What 2Do's you today ?",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 10.0),
                    child: TextFormField(
                      controller: kegiatan,
                      decoration: InputDecoration(
                          labelText: "Your 2Do",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          )),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "2Do must be assign";
                        }
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _save().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                                content: const Text('Data saved successfully'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                                content: const Text(
                                    'Error occured, Data failed to saved'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                      color: Colors.white,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'RobotoMono',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
