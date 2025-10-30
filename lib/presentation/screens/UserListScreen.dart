import 'package:flutter/material.dart';
import 'package:giuaky/application/UserViewModel.dart';
import 'package:giuaky/authentication/AuthGate.dart';
import 'package:giuaky/authentication/FirebaseAuth.dart';
import 'package:giuaky/presentation/screens/AddUserScreen.dart';
import 'package:giuaky/presentation/widgets/UserCardWidget.dart';
import 'package:provider/provider.dart';

// Import hàm đăng xuất của bạn (Điều chỉnh đường dẫn này)-
// import '../../authentication/FirebaseAuth.dart';


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
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.viewModel.getUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSignOut() async {
    try {
      await signOut();

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => AuthGate(),
          ),
              (Route<dynamic> route) => false,
        );
      }
    } on Exception catch (e) {
      // Xử lý lỗi (ví dụ: hiển thị thông báo lỗi)
      print("Lỗi Đăng xuất: ${e.toString()}");
      // Có thể thêm SnackBar tại đây để báo lỗi cho người dùng
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        actions: [
          IconButton.outlined(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Nhập từ khóa...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () async {
                    _searchController.clear();
                    setState(() {
                      widget.viewModel.searchQuery = '';

                    });
                    await widget.viewModel.fetchUsers();
                  },
                )
                    : null,
              ),
              onChanged: (value) async {
                setState(() {
                  widget.viewModel.searchQuery = value;

                });
                await widget.viewModel.fetchUsers();
              },
            ),
          ),

          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewModel,
              builder: (context, child) {
                final displayList = widget.viewModel.filteredUserList;

                if (displayList.isEmpty && displayList.isEmpty) {
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
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final user = displayList[index];
                    return UserCardWidget(
                      user: user,
                      deleteUser: () => widget.viewModel.deleteUser(user.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserScreen(viewModel: context.read()),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}