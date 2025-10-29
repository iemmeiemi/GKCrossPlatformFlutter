import 'package:flutter/material.dart';
import 'package:giuaky/application/UserViewModel.dart';
import 'package:giuaky/data/User.dart';
import 'package:giuaky/presentation/screens/AddUserScreen.dart';
import 'package:giuaky/presentation/widgets/UserCardWidget.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  final UserViewModel viewModel;

  const UserListScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  void initState() {
    super.initState();
    widget.viewModel.getUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          if (widget.viewModel.userList.isEmpty) {
            return const Center(child: Text("There is no data"));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 350,
              mainAxisExtent: 300,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: widget.viewModel.userList.length,
            itemBuilder: (context, index) {
              final user = widget.viewModel.userList[index];
              return UserCardWidget(
                user: user,
                deleteUser: () => widget.viewModel.deleteUser(user.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserScreen(viewModel: context.read()), // Trang bạn muốn chuyển sang
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
