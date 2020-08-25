import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCategoryModel> infoCategoryList;
  Function(String) onEditInfoCategoryCurrent;
  Function(String) onTreeInfoCategoryCurrent;
  ViewModel();
  ViewModel.build({
    @required this.infoCategoryList,
    @required this.onEditInfoCategoryCurrent,
    @required this.onTreeInfoCategoryCurrent,
  }) : super(equals: [
          infoCategoryList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoCategoryList: state.infoCategoryState.infoCategoryList,
        onEditInfoCategoryCurrent: (String id) {
          dispatch(SetInfoCategoryCurrentSyncInfoCategoryAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoCategoryEdit));
        },
        onTreeInfoCategoryCurrent: (String id) {
          dispatch(SetInfoCategoryCurrentSyncInfoCategoryAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoCategoryItemTree));
          if (state.infoCategoryState.infoCategoryCurrent.setorRef != null) {
            dispatch(GetDocInfoSetorCurrentAsyncInfoSetorAction(
                state.infoCategoryState.infoCategoryCurrent.setorRef.id));
          }
        },
      );
}

class InfoCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoCategoryListAsyncInfoCategoryAction()),
      builder: (context, viewModel) => InfoCategoryListDS(
        infoCategoryList: viewModel.infoCategoryList,
        onEditInfoCategoryCurrent: viewModel.onEditInfoCategoryCurrent,
        onTreeInfoCategoryCurrent: viewModel.onTreeInfoCategoryCurrent,
      ),
    );
  }
}
