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
          // ListTile(
          //   leading: Icon(
          //     Icons.work,
          //   ),
          //   title: Text('Usuários'),
          //   onTap: () => Navigator.pushNamed(context, Routes.userList),
          // ),
          ListTile(
            leading: Icon(
              Icons.format_textdirection_r_to_l,
            ),
            title: Text('Organizador de informações e indicadores'),
            onTap: () => Navigator.pushNamed(context, Routes.infoIndOwnerList),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.traffic,
          //   ),
          //   title: Text('Organizador de info/ind'),
          //   onTap: () =>
          //       Navigator.pushNamed(context, Routes.infoIndOrganizerList),
          // ),
          ListTile(
            leading: Icon(
              Icons.view_carousel,
            ),
            title: Text('Informações'),
            onTap: () => Navigator.pushNamed(context, Routes.infoCodeList),
          ),
          ListTile(
            leading: Icon(
              Icons.line_style,
            ),
            title: Text('Minhas categorias de informações'),
            onTap: () => Navigator.pushNamed(context, Routes.infoCategoryList),
          ),

          ListTile(
            leading: Icon(
              Icons.location_on,
            ),
            title: Text('Áreas'),
            onTap: () => Navigator.pushNamed(context, Routes.infoSetorList),
          ),
        ],
      ),
    );
  }
}
