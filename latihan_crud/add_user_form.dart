import 'package:flutter/material.dart';
import 'package:flutter_application_1/material/latihan_CRUD/user_model.dart';
import 'package:validators/validators.dart' as validators;

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  UserModel? data;
  String? name;
  String? email;
  String? gender;

  // String _selectedVal = "Wanita";

  // List<String> _gender = ["Wanita", "Pria"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Form Input User'),
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
                  decoration: InputDecoration(
                      hintText: "Input Name",
                      labelText: "Name",
                      icon: Icon(
                        Icons.people,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (newValue) {
                    setState(() {
                      name = newValue;
                    });
                  },
                  // validator: ((value) {
                  //   return (value != null) ? 'Nama tidak boleh kosong' : null;
                  // }),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Input Email",
                      labelText: "Email",
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (newValue) {
                    setState(() {
                      email = newValue;
                    });
                  },
                  // validator: ((value) {
                  //   return (value != null) ? 'Email tidak boleh kosong' : null;
                  // }),
                ),
                SizedBox(
                  height: 10,
                ),
                // Text("Gender : "),
                // ListView.builder(
                //   scrollDirection: Axis.vertical,
                //   shrinkWrap: true,
                //   itemCount: _gender.length,
                //   itemBuilder: (context, index) {
                //     return RadioListTile(
                //       title: Text("${_gender[index]}"),
                //       value: index,
                //       groupValue: gender,
                //       onChanged: (value) {
                //         setState(() {
                //           // gender = value!;
                //           // _selectedVal = value!;
                //         });
                //       },
                //     );
                //   },
                // ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Input Gender",
                      labelText: "Gender",
                      icon: Icon(
                        Icons.family_restroom,
                        color: Colors.blue,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onChanged: (newValue) {
                    setState(() {
                      gender = newValue;
                    });
                  },
                  // validator: ((value) {
                  //   return (value != null) ? 'Gender tidak boleh kosong' : null;
                  // }),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() async {
                        data = new UserModel(
                            id: 0, name: name!, email: email!, gender: gender!);
                        await createUser(data!);
                        Navigator.pushNamed(context, '/show');
                      });
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
