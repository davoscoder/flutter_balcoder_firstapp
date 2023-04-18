import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_balcoder_firstapp/ui/users/user_model.dart';

class UserFormPage extends StatefulWidget {
  UserFormPage({super.key, required this.userModel});

  UserModel userModel;

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerLastName;
  late TextEditingController _controllerDocument;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.userModel.key != null) {
      _controllerName = TextEditingController(text: widget.userModel.name);
      _controllerLastName =
          TextEditingController(text: widget.userModel.lastName);
      _controllerDocument =
          TextEditingController(text: widget.userModel.document.toString());
    } else {
      _controllerName = TextEditingController();
      _controllerLastName = TextEditingController();
      _controllerDocument = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
                child: Padding(
          padding: EdgeInsets.only(right: 40),
          child: (Text('Usuarios')),
        ))),
        body: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                controller: _controllerName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Apellido'),
                controller: _controllerLastName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'CC'),
                keyboardType: TextInputType.number,
                controller: _controllerDocument,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                UserModel userModel = UserModel(
                    name: _controllerName.text,
                    lastName: _controllerLastName.text,
                    document: int.parse(_controllerDocument.text));
                if (widget.userModel.key != null) {
                  FirebaseFirestore.instance
                      .collection('dataCollection')
                      .doc(widget.userModel.key)
                      .update(userModel.toJson())
                      .then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  userModel.isDeleted = false;
                  FirebaseFirestore.instance
                      .collection('dataCollection')
                      .add(userModel.toJson())
                      .then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              child: Container(
                height: 40,
                width: 180,
                decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Center(
                  child: Text(
                    widget.userModel.key != null ? 'Actuaizar ' : 'Guardar',
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
