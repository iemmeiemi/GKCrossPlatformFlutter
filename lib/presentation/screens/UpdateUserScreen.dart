import 'dart:io';
import 'package:flutter/material.dart';
import 'package:giuaky/application/UserViewModel.dart';
import 'package:giuaky/data/User.dart';
import '../../utils/FilePicker.dart';

class UpdateUserScreen extends StatefulWidget {
  final UserViewModel viewModel;
  final User user; // user cần update

  const UpdateUserScreen({
    super.key,
    required this.viewModel,
    required this.user,
  });

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String _fileUrl = "";

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
    _fileUrl = widget.user.image;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateUser() {
    if (_formKey.currentState!.validate()) {
      final updatedUser = {
        "id": widget.user.id,
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "image": _fileUrl,
      };

      widget.viewModel.updateUser(widget.user.id, updatedUser); // gọi hàm updateUser trong ViewModel
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update User")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                const SizedBox(height: 16),
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
                        ? Image.file(
                      File(_fileUrl),
                      width: 200,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Nếu là URL online thì hiển thị bằng NetworkImage
                        return Image.network(
                          _fileUrl,
                          width: 200,
                          height: 150,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Container(
                      width: 200,
                      height: 150,
                      color: Colors.grey,
                    ),
                    IconButton.outlined(
                      onPressed: () async {
                        var url = await FilePickerUtils().imagePicker();
                        setState(() {
                          _fileUrl = url;
                        });
                      },
                      icon: const Icon(Icons.image),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _updateUser,
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
