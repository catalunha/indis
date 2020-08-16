import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/user/user_logged_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String email;
  String name;

  Function() onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.email,
    @required this.name,
    @required this.onUpdate,
  }) : super(equals: [
          email,
          name,
        ]);

  @override
  ViewModel fromStore() => ViewModel.build(
        email: state.loggedState.userModelLogged?.email ?? '',
        name: state.loggedState.userModelLogged?.name ?? '',
        onUpdate: () {},
      );
}

class UserLoggedEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => UserLoggedEditDS(
        email: viewModel.email,
        name: viewModel.name,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
