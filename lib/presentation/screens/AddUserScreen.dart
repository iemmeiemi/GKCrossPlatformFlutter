import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:giuaky/application/UserViewModel.dart';
import 'package:giuaky/data/User.dart';

import '../../utils/FilePicker.dart';

class AddUserScreen extends StatefulWidget {
  final UserViewModel viewModel;
  const AddUserScreen({super.key, required this.viewModel});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String _fileUrl = "";

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      final newUser = {
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "image": _fileUrl
      };
      widget.viewModel.addUser(newUser); // thêm user vào viewModel
      Navigator.pop(context); // quay về màn hình trước
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter username" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter email" : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter password" : null,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _fileUrl.isNotEmpty
                    ? Image.file(File(_fileUrl), width: 200, height: 150, fit: BoxFit.cover)
                    : Container(width: 200, height: 150, color: Colors.grey),
                  IconButton.outlined(
                      onPressed: () async {
                        var url = await FilePickerUtils().imagePicker();
                        setState(() {
                          _fileUrl = url;
                      });},
                      icon: Icon(Icons.image))
                ]
              ),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
