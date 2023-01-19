import 'package:flutter/material.dart';
import 'package:flutter_application_1/material/latihan_crud/add_user_form.dart';
import 'package:flutter_application_1/material/latihan_crud/update_user_form.dart';
import 'package:flutter_application_1/material/latihan_crud/user_model.dart';

// late UserModel oldValue;

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/show': (context) => ShowUser(),
        '/add': (context) => AddUserForm(),
        '/update': (context) => UpdateUserForm()
        // '/update': (context) => UpdateUserForm(oldValue: widget.oldValue),
      },
      initialRoute: '/show',
      // home: ShowUser(),
    );
  }
}

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  late Color avacol;
  late Future<List<UserModel>> usersData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersData = getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return AddUserForm();
          // }));
          Navigator.pushNamed(context, '/add');
        },
      ),
      appBar: AppBar(
        title: const Text('Latihan CRUD'),
      ),
      body: Container(
        child: FutureBuilder<List<UserModel>>(
          future: usersData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  if (snapshot.data?[index].gender == 'Perempuan') {
                    avacol = Colors.deepOrange;
                  } else {
                    avacol = Colors.orange;
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: avacol,
                      radius: 25,
                      child: Center(
                        child: Text(
                          '${snapshot.data?[index].name[0]}'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ),
                    title: Text(
                      '${snapshot.data?[index].name}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: (snapshot.data?[index].email != null)
                        ? Text(
                            '${snapshot.data?[index].email}',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.lightBlue,
                          onPressed: () {
                            Navigator.pushNamed(context, '/update',
                                arguments: {'data': snapshot.data![index]});
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.pink,
                          // onPressed: () async {
                          //   await deleteUser(snapshot.data![index].id);
                          //   setState(() {});
                          // },
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Delete"),
                                  content:
                                      Text("Are you sure delete this item?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          await deleteUser(
                                              snapshot.data![index].id);
                                          Navigator.pushNamed(context, '/show');
                                        },
                                        child: Text("Yes")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/show');
                                        },
                                        child: Text("No"))
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
