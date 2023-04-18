import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_firstapp/ui/users/user_form_page.dart';
import 'package:flutter_balcoder_firstapp/ui/users/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  List<UserModel> userList = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('dataCollection')
            .where('isDeleted', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
            userList = [];
            docs.forEach((value) {
              dynamic data = value.data();
              userList.add(UserModel.fromSnapshot(data: data, id: value.id));
              print(data!['name']);
            });

            return userList.isEmpty
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return UserFormPage(
                              userModel: userList[index],
                            );
                          }));
                        },
                        child: ListTile(
                          trailing: GestureDetector(
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('dataCollection')
                                    .doc(userList[index].key)
                                    .update({'isDeleted': true}).then(
                                        (value) {});
                              },
                              child: Icon(Icons.delete)),
                          title: Text(userList[index].name!),
                          subtitle: Text(userList[index].document.toString()),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20))),
                          ),
                        ),
                      );
                    },
                    itemCount: userList.length,
                  );
          }
          return Container();
        },
      ),
      appBar: AppBar(
        title: const Center(child: Text('My Aplication')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserFormPage(userModel: UserModel());
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  getData() {
    FirebaseFirestore.instance
        .collection('dataCollection')
        .doc('CUyysBpV2W2l3JXfZWQJ')
        .snapshots()
        .listen((value) {
      setState(() {
        var data = value.data();
        print(data?['name']);
      });
    });
  }
}
