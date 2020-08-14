import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  UserModel userModel;
  bool existOrganizerSelected;
  ViewModel();
  ViewModel.build({
    @required this.userModel,
    @required this.existOrganizerSelected,
  }) : super(equals: [
          userModel,
          existOrganizerSelected,
        ]);

  @override
  ViewModel fromStore() => ViewModel.build(
        userModel: state.loggedState.userModelLogged,
        existOrganizerSelected:
            state.infoIndOrganizerState.infoIndOrganizerCurrent != null,
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => HomePageDS(
        userModel: viewModel.userModel,
        existOrganizerSelected: viewModel.existOrganizerSelected,
      ),
    );
  }
}
