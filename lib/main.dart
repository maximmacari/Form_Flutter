import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Form"),
        ),
        body: MyForm(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  void _resetFields() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
  }
  void _resetFocus() {
   _nameFocus.unfocus();
   _phoneFocus.unfocus();
   _emailFocus.unfocus();
  }

  final RegExp phoneReg = RegExp(r'^[()\d-]{1,9}$');


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: Icon(Icons.person, color: Colors.cyan),
              labelText: "Name",
            ),
            validator: (value) {
              if (value.isEmpty) return "Required field";
            },
            controller: _nameController,
            focusNode: _nameFocus,
          ),
          TextFormField(
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                prefixIcon: Icon(Icons.phone, color: Colors.cyan),
                labelText: "Phone",
              ),
              validator: (value) {
                if (value.isEmpty) return "Required field";
              },
              controller: _phoneController,
              focusNode: _phoneFocus,
              inputFormatters: [
                new FilteringTextInputFormatter.allow(phoneReg)
              ],),
          TextFormField(
            decoration: const InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: Icon(Icons.email, color: Colors.cyan),
              labelText: "Email",
            ),
            validator: (value) {
              if (value.isEmpty) return "Required field";
            },
            controller: _emailController,
            focusNode: _emailFocus
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Registering data")));
                  _resetFields();
                  _resetFocus();
                }
              },
              child: Text(
                "Send",
                maxLines: 1,
              ),
              style: TextButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.blue),
            ),
          )),
        ],
      ),
    );
  }
}
