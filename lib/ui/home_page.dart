import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  String name = '';

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: Center(
        //   child: Text('Body'),
        // ),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Text(name),
              Spacer(),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text('My Aplication')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count = count + 1;
          });
          print(count);
        },
        child: Icon(Icons.add),
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
        name = data?['name'];
      });
    });
  }
}
