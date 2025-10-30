import 'package:flutter/material.dart';


import '../../authentication/FirebaseAuth.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Tạo hàm xử lý đăng nhập mẫu
  void _handleLogin(String username, String password) {
    print('--- Đăng nhập cơ bản ---');
    print('Username: $username');
    print('Password: $password');
  }

  // Tạo hàm xử lý đăng nhập bằng Email mẫu
  Future<void> _loginWithEmail() async {
    try {
      await signInWithGoogle();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng GlobalKey để quản lý trạng thái Form
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Nhập'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Tiêu đề
              const Text(
                'Chào mừng bạn trở lại',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 1. Ô nhập Username
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Không được để trống tên người dùng.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 2. Ô nhập Password
              TextFormField(
                controller: passwordController,
                obscureText: true, // Luôn ẩn mật khẩu
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Không được để trống mật khẩu.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // 3. Button Đăng Nhập Chính
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _handleLogin(usernameController.text, passwordController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Đăng Nhập', style: TextStyle(color: Colors.white)),
              ),

              const SizedBox(height: 30),

              const Divider(), // Đường phân cách đơn giản

              const SizedBox(height: 20),

              // Button Icon Đăng nhập bằng Email
              const Text(
                'Hoặc Đăng nhập nhanh:',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 15),

              Center(
                child: IconButton(
                  onPressed: _loginWithEmail,
                  icon: const Icon(Icons.email, size: 36, color: Colors.teal),
                  tooltip: 'Đăng nhập bằng Email',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
