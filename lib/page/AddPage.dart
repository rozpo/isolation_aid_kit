import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isolation_aid_kit/firebase/store/Request.dart';

import 'HomePage.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  static const String errorFieldMsg = "To pole nie może być puste";
  String title = '';
  String description = '';
  String address = '';

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'wstecz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidateMode,
          onChanged: () {
            Form.of(primaryFocus.context).save();
          },
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Nowe zlecenie",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 20)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: TextFormField(
                  onSaved: (String value) {
                    this.title = value;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    icon: Icon(Icons.subject),
                    labelText: 'Nazwa *',
                  ),
                  validator: _validateField,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: TextFormField(
                  onSaved: (String value) {
                    this.description = value;
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      icon: Icon(Icons.description),
                      labelText: 'Opis potrzeby *'),
                  maxLines: 5,
                  validator: _validateField,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: TextFormField(
                  onSaved: (String value) {
                    this.address = value;
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      icon: Icon(Icons.home),
                      labelText: 'Adres *'),
                  validator: _validateField,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        label: Text("Dodaj zlecenie"),
        icon: Icon(Icons.done),
        onPressed: () {
          _handleSubmitted();
        },
      ),
      // ]),
    );
  }

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode = AutovalidateMode.always;
    } else {
      form.save();
      addRequest(this.title, this.description, this.address);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    }
  }

  String _validateField(String value) {
    if (value.isEmpty) {
      return errorFieldMsg;
    }
    return null;
  }
}
