import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/states/types_states.dart';
import 'package:indis/uis/info_code/info_code_ordering_ds.dart';
import 'package:meta/meta.dart';

class ViewModel extends BaseModel<AppState> {
  InfoCodeOrder infoCodeOrder;
  Function(InfoCodeOrder) onSelectOrder;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeOrder,
    @required this.onSelectOrder,
  }) : super(equals: [
          infoCodeOrder,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeOrder: state.infoCodeState.infoCodeOrder,
        onSelectOrder: (InfoCodeOrder infoCodeOrder) {
          dispatch(
            SetInfoCodeOrderSyncInfoCodeAction(
              infoCodeOrder,
            ),
          );
        },
      );
}

class InfoCodeOrdering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) =>
          InfoCodeOrderingDS(
        infoCodeOrder: viewModel.infoCodeOrder,
        onSelectOrder: viewModel.onSelectOrder,
      ),
    );
  }
}
