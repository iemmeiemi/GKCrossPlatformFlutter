
import 'package:flutter/material.dart';
import 'package:giuaky/data/User.dart';
import 'package:giuaky/presentation/screens/UpdateUserScreen.dart';
import 'package:provider/provider.dart';

class UserCardWidget extends StatelessWidget {
  final User user;
  final VoidCallback deleteUser;

  const UserCardWidget({super.key, required this.user, required this.deleteUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        user.image.isEmpty ? Container(width: 150, height: 150, color: Colors.blue) :
        Image.network(
          user.image,
          width: 150,
          height: 150,
          fit: BoxFit.fitWidth,

        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.username),
                Text(user.email),
                Text(user.password),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.outlined(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateUserScreen(viewModel: context.read(), user: user), // Trang bạn muốn chuyển sang
                            ),
                          );
                        },
                        icon: Icon(Icons.edit)),
                    IconButton.outlined(onPressed: deleteUser, icon: Icon(Icons.delete)),

                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
