import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/conectors/info_category/info_category_data_edit.dart';
import 'package:indis/conectors/info_category/info_category_edit.dart';
import 'package:indis/conectors/info_category/info_category_list.dart';
import 'package:indis/conectors/info_category/info_category_data_tree.dart';
import 'package:indis/conectors/info_code/info_code_edit.dart';
import 'package:indis/conectors/info_code/info_code_list.dart';
import 'package:indis/conectors/info_data/info_data_edit.dart';
import 'package:indis/conectors/info_data/info_data_list.dart';
import 'package:indis/conectors/info_ind_owner/info_ind_owner_edit.dart';
import 'package:indis/conectors/info_ind_owner/info_ind_owner_list.dart';

import 'package:indis/conectors/user/user_list.dart';
import 'package:indis/conectors/user/user_logged_edit.dart';
import 'package:indis/conectors/welcome.dart';

import 'package:indis/states/app_state.dart';

class Routes {
  static final home = '/';
  static final userList = '/userList';
  static final userEdit = '/userEdit';
  static final infoIndOwnerList = '/infoIndOwnerList';
  static final infoIndOwnerEdit = '/infoIndOwnerEdit';
  static final infoCategoryList = '/infoCategoryList';
  static final infoCategoryEdit = '/infoCategoryEdit';
  static final infoCategoryDataTree = '/infoCategoryDataTree';
  static final infoCategoryDataEdit = '/infoCategoryDataEdit';
  static final infoCodeList = '/infoCodeList';
  static final infoCodeEdit = '/infoCodeEdit';
  static final infoSetorList = '/infoSetorList';
  static final infoSetorEdit = '/infoSetorEdit';

  static final routes = {
    home: (BuildContext context) => UserExceptionDialog<AppState>(
          child: Welcome(),
        ),
    userList: (BuildContext context) => UserList(),
    userEdit: (BuildContext context) => UserLoggedEdit(),
    infoIndOwnerList: (BuildContext context) => InfoIndOwnerList(),
    infoIndOwnerEdit: (BuildContext context) => InfoIndOwnerEdit(),
    infoCategoryList: (BuildContext context) => InfoCategoryList(),
    infoCategoryEdit: (BuildContext context) => InfoCategoryEdit(),
    infoCategoryDataTree: (BuildContext context) => InfoCategoryDataTree(),
    infoCategoryDataEdit: (BuildContext context) => InfoCategoryDataEdit(),
    infoCodeList: (BuildContext context) => InfoCodeList(),
    infoCodeEdit: (BuildContext context) => InfoCodeEdit(),
    infoSetorList: (BuildContext context) => InfoSetorList(),
    infoSetorEdit: (BuildContext context) => InfoSetorEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
