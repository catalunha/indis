import 'package:flutter/material.dart';
import 'package:indis/conectors/user/user_ordering.dart';
import 'package:indis/models/user_model.dart';

class UserListDS extends StatelessWidget {
  final List<UserModel> userList;

  const UserListDS({
    Key key,
    this.userList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${userList.length} usuários'),
        actions: [UserOrdering()],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            child: ListTile(
              title: Text('${user.name}'),
              subtitle: Text('Email: ${user.email}\nuserModel: $user'),
            ),
          );
        },
      ),
    );
  }
}
