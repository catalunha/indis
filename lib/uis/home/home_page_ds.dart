import 'package:flutter/material.dart';
import 'package:indis/conectors/components/logout_button.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/routes.dart';

class HomePageDS extends StatelessWidget {
  final UserModel userModel;

  const HomePageDS({
    Key key,
    this.userModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INDIS - ${userModel?.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.green),
            tooltip: 'Name: ${userModel?.name}',
            onPressed: () {
              Navigator.pushNamed(context, Routes.userEdit);
            },
          ),
          LogoutButton(),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.work,
            ),
            title: Text('Usuários'),
            onTap: () => Navigator.pushNamed(context, Routes.userList),
          ),
        ],
      ),
    );
  }
}
