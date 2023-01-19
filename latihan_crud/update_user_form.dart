import 'package:flutter/material.dart';
import 'package:flutter_application_1/material/latihan_crud/user_model.dart';
import 'package:validators/validators.dart' as validators;

class UpdateUserForm extends StatefulWidget {
  UpdateUserForm({super.key});

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  UserModel? data;
  String? name;
  String? email;
  String? gender;

  // String _selectedVal = "Wanita";

  // List<String> _gender = ["Wanita", "Pria"];

  @override
  Widget build(BuildContext context) {
    final dataUser =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final nameController = TextEditingController(text: dataUser['data'].name);
    final emailController = TextEditingController(text: dataUser['data'].email);
    final genderController =
        TextEditingController(text: dataUser['data'].gender);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Form Update User'),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autofocus: true,
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Name",
                      icon: Icon(
                        Icons.people,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (newValue) {
                    // setState(() {
                    //   if (newValue == null) {
                    //     name = widget.oldValue.name;
                    //   } else {
                    //     name = newValue;
                    //   }
                    // });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofocus: true,
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (newValue) {
                    // setState(() {});
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofocus: true,
                  controller: genderController,
                  decoration: InputDecoration(
                      labelText: "Gender",
                      icon: Icon(
                        Icons.family_restroom,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (newValue) {
                    // setState(() {
                    //   // if (newValue == null) {
                    //   //   gender = widget.oldValue.gender;
                    //   // } else {
                    //   //   gender = newValue;
                    //   // }
                    // });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Berhasil"),
                          content: Text("Data berhasil diupdate"),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    data = new UserModel(
                                        id: 0,
                                        name: nameController.text,
                                        email: emailController.text,
                                        gender: genderController.text);
                                  });
                                  await updateUser(dataUser['data'].id, data!);
                                  Navigator.pushNamed(context, '/show');
                                },
                                child: Text("OK"))
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
