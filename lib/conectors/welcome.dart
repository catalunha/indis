import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:indis/conectors/home/home_page.dart';
import 'package:indis/conectors/login/login_page.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/states/types_states.dart';

class ViewModel extends BaseModel<AppState> {
  bool logged;
  ViewModel();
  ViewModel.build({@required this.logged}) : super(equals: [logged]);
  @override
  ViewModel fromStore() => ViewModel.build(
      logged: state.loggedState.authenticationStatusLogged ==
              AuthenticationStatusLogged.authenticated
          ? true
          : false);
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) =>
          viewModel.logged ? HomePage() : LoginPage(),
    );
  }
}
