import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

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
              Text('Texto 1'),
              Text('Texto 2'),
              Text(count.toString()),
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
}
