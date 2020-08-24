import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/user/user_select_to_infosetor_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<UserModel> userModelList;
  List<String> infoSetorCurrentEditorsMapKeys;
  Function(UserModel, bool) onSetUserInInfoSetorEditorsMap;
  ViewModel();
  ViewModel.build({
    @required this.userModelList,
    @required this.infoSetorCurrentEditorsMapKeys,
    @required this.onSetUserInInfoSetorEditorsMap,
  }) : super(equals: [
          infoSetorCurrentEditorsMapKeys,
          userModelList,
        ]);
  _userModelList() {
    List<UserModel> _userModelList = [];
    _userModelList.addAll(state.userState.userList);
    // if (state.infoSetorState.infoSetorCurrent?.editorsMap != null) {
    // _userModelList.removeWhere(
    //     (element) => element.id == state.loggedState.userModelLogged.id);
    // }
    _userModelList.sort((a, b) => a.name.compareTo(b.name));
    return _userModelList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        userModelList: _userModelList(),
        infoSetorCurrentEditorsMapKeys:
            state.infoSetorState.infoSetorCurrent?.editorsMap?.keys?.toList() ??
                [],
        onSetUserInInfoSetorEditorsMap:
            (UserModel userModel, bool addOrRemove) {
          dispatch(SetUserInInfoSetorEditorsSyncInfoSetorAction(
            userModel: userModel,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class UserSelectToInfoSetorEditors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => UserSelectToInfoSetorEditorsDS(
        userModelList: viewModel.userModelList,
        infoSetorCurrentEditorsMapKeys:
            viewModel.infoSetorCurrentEditorsMapKeys,
        onSetUserInInfoSetorEditorsMap:
            viewModel.onSetUserInInfoSetorEditorsMap,
      ),
    );
  }
}
