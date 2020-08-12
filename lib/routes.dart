import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'package:indis/conectors/user/user_list.dart';
import 'package:indis/conectors/user/user_logged_edit.dart';
import 'package:indis/conectors/welcome.dart';

import 'package:indis/states/app_state.dart';

class Routes {
  static final home = '/';
  static final userEdit = '/userEdit';
  static final userList = '/userList';

  static final routes = {
    home: (BuildContext context) => UserExceptionDialog<AppState>(
          child: Welcome(),
        ),
    userEdit: (BuildContext context) => UserLoggedEdit(),
    userList: (BuildContext context) => UserList(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
