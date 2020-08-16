import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_select_ds.dart.md';

class ViewModel extends BaseModel<AppState> {
  List<InfoCodeModel> infoCodeList;
  InfoCategoryModel infoCategoryCurrent;
  Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeList,
    @required this.infoCategoryCurrent,
    @required this.onSetInfoCodeInInfoCategory,
  }) : super(equals: [
          infoCategoryCurrent,
          infoCodeList,
        ]);
  _infoCodeList() {
    List<InfoCodeModel> infoCodeList = [];
    infoCodeList.addAll(state.infoCodeState.infoCodeList);
    // for (var group in state.infoCategoryState.infoCategoryList) {
    //     if (group.infoCodeRefMap.id == state.infoCategoryState.groupCurrent.moduleRef.id) {
    //       if (group.workerRefMap != null && group.workerRefMap.isNotEmpty) {
    //         for (var workerRef in group.workerRefMap.entries) {
    //           workerListClean.removeWhere((element) {
    //             return element.id == workerRef.value.id;
    //           });
    //         }
    //       }
    //     }

    // }
    return infoCodeList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeList: _infoCodeList(),
        infoCategoryCurrent: state.infoCategoryState.infoCategoryCurrent,
        onSetInfoCodeInInfoCategory:
            (InfoCodeModel infoCodeRef, bool addOrRemove) {
          dispatch(SetInfoCodeInInfoCategorySyncInfoCategoryAction(
            infoCodeRef: infoCodeRef,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class InfoCodeSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoCodeListAsyncInfoCodeAction()),
      builder: (context, viewModel) => InfoCodeSelectDS(
        infoCodeList: viewModel.infoCodeList,
        infoCategoryCurrent: viewModel.infoCategoryCurrent,
        onSetInfoCodeInInfoCategory: viewModel.onSetInfoCodeInInfoCategory,
      ),
    );
  }
}
