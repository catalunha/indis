import 'package:flutter/material.dart';
import 'package:indis/conectors/components/logout_button.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/routes.dart';

class HomePageDS extends StatelessWidget {
  final UserModel userModel;
  final bool existOrganizerSelected;

  const HomePageDS({
    Key key,
    this.userModel,
    this.existOrganizerSelected,
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
            title: Text('Proprietário de info/ind'),
            onTap: () => Navigator.pushNamed(context, Routes.infoIndOwnerList),
          ),
          ListTile(
            leading: Icon(
              Icons.traffic,
            ),
            title: Text('Organizador de info/ind'),
            onTap: () =>
                Navigator.pushNamed(context, Routes.infoIndOrganizerList),
          ),
          existOrganizerSelected
              ? ListTile(
                  leading: Icon(
                    Icons.line_style,
                  ),
                  title: Text('Categoria de info'),
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.infoCategoryList),
                )
              : Container(),
          ListTile(
            leading: Icon(
              Icons.view_carousel,
            ),
            title: Text('Informação'),
            onTap: () => Navigator.pushNamed(context, Routes.infoCodeList),
          ),
          ListTile(
            leading: Icon(
              Icons.location_on,
            ),
            title: Text('Áreas'),
            onTap: () => Navigator.pushNamed(context, Routes.infoDataList),
          ),
        ],
      ),
    );
  }
}
