import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/conectors/info_category/info_category_item_edit.dart';
import 'package:indis/conectors/info_category/info_category_edit.dart';
import 'package:indis/conectors/info_category/info_category_list.dart';
import 'package:indis/conectors/info_category/info_category_item_tree.dart';
import 'package:indis/conectors/info_code/info_code_edit.dart';
import 'package:indis/conectors/info_code/info_code_list.dart';
import 'package:indis/conectors/info_ind_owner/info_ind_owner_edit.dart';
import 'package:indis/conectors/info_ind_owner/info_ind_owner_list.dart';
import 'package:indis/conectors/info_setor/info_setor_edit.dart';
import 'package:indis/conectors/info_setor/info_setor_list.dart';
import 'package:indis/conectors/info_setor/info_setor_source_edit.dart';
import 'package:indis/conectors/info_setor/info_setor_source_list.dart';
import 'package:indis/conectors/info_setor/info_setor_valuedata_list.dart';

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
  static final infoCategoryItemTree = '/infoCategoryItemTree';
  static final infoCategoryItemEdit = '/infoCategoryItemEdit';
  static final infoCodeList = '/infoCodeList';
  static final infoCodeEdit = '/infoCodeEdit';
  static final infoSetorList = '/infoSetorList';
  static final infoSetorEdit = '/infoSetorEdit';
  static final infoSetorSourceList = '/infoSetorSourceList';
  static final infoSetorSourceEdit = '/infoSetorSourceEdit';
  static final infoSetorValueDataList = '/infoSetorValueDataList';
  static final infoSetorValueDataEdit = '/infoSetorValueDataEdit';

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
    infoCategoryItemTree: (BuildContext context) => InfoCategoryItemTree(),
    infoCategoryItemEdit: (BuildContext context) => InfoCategoryItemEdit(),
    infoCodeList: (BuildContext context) => InfoCodeList(),
    infoCodeEdit: (BuildContext context) => InfoCodeEdit(),
    infoSetorList: (BuildContext context) => InfoSetorList(),
    infoSetorEdit: (BuildContext context) => InfoSetorEdit(),
    infoSetorSourceList: (BuildContext context) => InfoSetorSourceList(),
    infoSetorSourceEdit: (BuildContext context) => InfoSetorSourceEdit(),
    infoSetorValueDataList: (BuildContext context) => InfoSetorValueDataList(),
    // infoSetorValueDataEdit: (BuildContext context) => InfoSetorValueDataEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
