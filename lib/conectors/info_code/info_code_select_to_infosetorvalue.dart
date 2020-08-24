import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_select_to_infosetorvalue_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCodeModel> infoCodeList;
  List<String> infoSetorCurrentValueMapKeys;
  Function(InfoCodeModel, bool) onSetInfoCodeInInfoSetorValueMapSyncGroupAction;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeList,
    @required this.infoSetorCurrentValueMapKeys,
    @required this.onSetInfoCodeInInfoSetorValueMapSyncGroupAction,
  }) : super(equals: [
          infoSetorCurrentValueMapKeys,
          infoCodeList,
        ]);
  _infoCodeList() {
    List<InfoCodeModel> _infoCodeList = [];
    _infoCodeList.addAll(state.infoCodeState.infoCodeList);
    return _infoCodeList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeList: _infoCodeList(),
        infoSetorCurrentValueMapKeys:
            state.infoSetorState.infoSetorCurrent?.valueMap?.keys?.toList() ??
                [],
        onSetInfoCodeInInfoSetorValueMapSyncGroupAction:
            (InfoCodeModel infoCodeModel, bool addOrRemove) {
          dispatch(SetInfoCodeInInfoSetorValueMapSyncInfoCodeAction(
            infoCodeModel: infoCodeModel,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class InfoCodeSelectToInfoSetorValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCodeSelectToInfoSetorValueDS(
        infoCodeList: viewModel.infoCodeList,
        infoSetorCurrentValueMapKeys: viewModel.infoSetorCurrentValueMapKeys,
        onSetInfoCodeInInfoSetorValueMapSyncGroupAction:
            viewModel.onSetInfoCodeInInfoSetorValueMapSyncGroupAction,
      ),
    );
  }
}
