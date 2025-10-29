import 'package:flutter/material.dart';
import 'package:giuaky/application/UserViewModel.dart';
import 'package:giuaky/data/User.dart';

class AddUserScreen extends StatefulWidget {
  final UserViewModel viewModel;

  const AddUserScreen({super.key, required this.viewModel});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      final newUser = {
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "image": "null"
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
