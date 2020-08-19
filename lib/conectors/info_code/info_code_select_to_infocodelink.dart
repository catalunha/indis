import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_select_to_infocodelink_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCodeModel> infoCodeList;
  List<String> infoCodeCurrentLinkMapKeys;
  Function(InfoCodeModel, bool) onSetInfoCodeInInfoCodeLinkMapSyncGroupAction;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeList,
    @required this.infoCodeCurrentLinkMapKeys,
    @required this.onSetInfoCodeInInfoCodeLinkMapSyncGroupAction,
  }) : super(equals: [
          infoCodeCurrentLinkMapKeys,
          infoCodeList,
        ]);
  _infoCodeList() {
    List<InfoCodeModel> _infoCodeList = [];
    _infoCodeList.addAll(state.infoCodeState.infoCodeList);
    _infoCodeList.removeWhere((element) =>
        element.infoIndOwnerRef.id !=
        state.infoCodeState.infoCodeCurrent.infoIndOwnerRef.id);
    _infoCodeList.removeWhere(
        (element) => element.id == state.infoCodeState.infoCodeCurrent.id);

    return _infoCodeList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeList: _infoCodeList(),
        infoCodeCurrentLinkMapKeys:
            state.infoCodeState.infoCodeCurrent?.linkMap?.keys?.toList() ?? [],
        onSetInfoCodeInInfoCodeLinkMapSyncGroupAction:
            (InfoCodeModel infoCodeModel, bool addOrRemove) {
          dispatch(SetInfoCodeInInfoCodeLinkMapSyncInfoCodeAction(
            infoCodeModel: infoCodeModel,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class InfoCodeSelectToInfoCodeLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCodeSelectToInfoCodeLinkDS(
        infoCodeList: viewModel.infoCodeList,
        infoCodeCurrentLinkMapKeys: viewModel.infoCodeCurrentLinkMapKeys,
        onSetInfoCodeInInfoCodeLinkMapSyncGroupAction:
            viewModel.onSetInfoCodeInInfoCodeLinkMapSyncGroupAction,
      ),
    );
  }
}
