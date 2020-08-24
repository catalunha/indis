import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_select_to_infocategorysetor_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoSetorModel> infoSetorList;
  String infoCategoryCurrentSetorRefId;
  Function(InfoSetorModel, bool)
      onSetInfoSetorInInfoCategorySetorSyncGroupAction;
  ViewModel();
  ViewModel.build({
    @required this.infoSetorList,
    @required this.infoCategoryCurrentSetorRefId,
    @required this.onSetInfoSetorInInfoCategorySetorSyncGroupAction,
  }) : super(equals: [
          infoCategoryCurrentSetorRefId,
          infoSetorList,
        ]);
  _infoSetorList() {
    List<InfoSetorModel> _infoSetorList = [];
    _infoSetorList.addAll(state.infoSetorState.infoSetorList);
    return _infoSetorList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        infoSetorList: _infoSetorList(),
        infoCategoryCurrentSetorRefId:
            state.infoCategoryState.infoCategoryCurrent?.setorRef?.id,
        onSetInfoSetorInInfoCategorySetorSyncGroupAction:
            (InfoSetorModel infoSetorModel, bool addOrRemove) {
          dispatch(SetInfoSetorInInfoCategorySetorSyncInfoCategoryAction(
            infoSetorModel: infoSetorModel,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class InfoSetorSelectToInfoCategorySetor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorSelectToInfoCategorySetorDS(
        infoSetorList: viewModel.infoSetorList,
        infoCategoryCurrentSetorRefId: viewModel.infoCategoryCurrentSetorRefId,
        onSetInfoSetorInInfoCategorySetorSyncGroupAction:
            viewModel.onSetInfoSetorInInfoCategorySetorSyncGroupAction,
      ),
    );
  }
}
