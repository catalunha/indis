import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_select_to_infocodeclone_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCodeModel> infoCodeList;
  List<String> infoCodeCurrentCloneMapKeys;
  Function(InfoCodeModel, bool) onSetInfoCodeInInfoCodeCloneMapSyncGroupAction;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeList,
    @required this.infoCodeCurrentCloneMapKeys,
    @required this.onSetInfoCodeInInfoCodeCloneMapSyncGroupAction,
  }) : super(equals: [
          infoCodeCurrentCloneMapKeys,
          infoCodeList,
        ]);
  _infoCodeList() {
    List<InfoCodeModel> _infoCodeList = [];
    _infoCodeList.addAll(state.infoCodeState.infoCodeList);
    _infoCodeList.removeWhere((element) =>
        element.infoIndOwnerRef.id ==
        state.infoCodeState.infoCodeCurrent.infoIndOwnerRef.id);
    return _infoCodeList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeList: _infoCodeList(),
        infoCodeCurrentCloneMapKeys:
            state.infoCodeState.infoCodeCurrent?.cloneMap?.keys?.toList() ?? [],
        onSetInfoCodeInInfoCodeCloneMapSyncGroupAction:
            (InfoCodeModel infoCodeModel, bool addOrRemove) {
          dispatch(SetInfoCodeInInfoCodeCloneMapSyncInfoCodeAction(
            infoCodeModel: infoCodeModel,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class InfoCodeSelectToInfoCodeClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCodeSelectToInfoCodeCloneDS(
        infoCodeList: viewModel.infoCodeList,
        infoCodeCurrentCloneMapKeys: viewModel.infoCodeCurrentCloneMapKeys,
        onSetInfoCodeInInfoCodeCloneMapSyncGroupAction:
            viewModel.onSetInfoCodeInInfoCodeCloneMapSyncGroupAction,
      ),
    );
  }
}
