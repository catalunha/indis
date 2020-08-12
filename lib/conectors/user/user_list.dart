import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:indis/actions/user_action.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/user/user_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<UserModel> userList;
  ViewModel();
  ViewModel.build({
    @required this.userList,
  }) : super(equals: [
          userList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        userList: state.userState.userList,
      );
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsUserListAsyncUserAction()),
      builder: (context, viewModel) => UserListDS(
        userList: viewModel.userList,
      ),
    );
  }
}
