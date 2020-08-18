import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_select_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCodeModel> infoCodeList;
  InfoCategoryItem categoryDataCurrent;
  Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeList,
    @required this.categoryDataCurrent,
    @required this.onSetInfoCodeInInfoCategory,
  }) : super(equals: [
          infoCodeList,
          categoryDataCurrent,
        ]);
  _infoCodeList() {
    List<InfoCodeModel> infoCodeList = [];
    infoCodeList.addAll(state.infoCodeState.infoCodeList);
    for (var categoryData
        in state.infoCategoryState.infoCategoryCurrent.itemMap.entries) {
      if (categoryData.value.infoCodeRefMap != null &&
          categoryData.value.infoCodeRefMap.isNotEmpty) {
        for (var infoCodeRef in categoryData.value.infoCodeRefMap.entries) {
          infoCodeList.removeWhere((element) => element.id == infoCodeRef.key);
        }
      }
    }
    return infoCodeList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeList: _infoCodeList(),
        categoryDataCurrent: state.infoCategoryState.infoCategoryItemCurrent,
        onSetInfoCodeInInfoCategory:
            (InfoCodeModel infoCodeRef, bool addOrRemove) {
          dispatch(SetInfoCodeInInfoCategoryDataSyncInfoCategoryAction(
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
        categoryDataCurrent: viewModel.categoryDataCurrent,
        onSetInfoCodeInInfoCategory: viewModel.onSetInfoCodeInInfoCategory,
      ),
    );
  }
}
