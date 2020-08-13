import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/conectors/information_owner/information_owner_edit.dart';
import 'package:indis/conectors/information_owner/information_owner_list.dart';

import 'package:indis/conectors/user/user_list.dart';
import 'package:indis/conectors/user/user_logged_edit.dart';
import 'package:indis/conectors/welcome.dart';

import 'package:indis/states/app_state.dart';

class Routes {
  static final home = '/';
  static final userList = '/userList';
  static final userEdit = '/userEdit';
  static final ownerList = '/ownerList';
  static final ownerEdit = '/ownerEdit';

  static final routes = {
    home: (BuildContext context) => UserExceptionDialog<AppState>(
          child: Welcome(),
        ),
    userList: (BuildContext context) => UserList(),
    userEdit: (BuildContext context) => UserLoggedEdit(),
    ownerList: (BuildContext context) => InformationOwnerList(),
    ownerEdit: (BuildContext context) => InformationOwnerEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
