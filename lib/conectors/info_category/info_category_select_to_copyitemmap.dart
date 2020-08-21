import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_select_to_copyitemmap_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCategoryModel> infoCategoryListToCopyItemMap;
  Function(InfoCategoryModel) onSetCopyItemMapInInfoCategory;
  ViewModel();
  ViewModel.build({
    @required this.infoCategoryListToCopyItemMap,
    @required this.onSetCopyItemMapInInfoCategory,
  }) : super(equals: [
          infoCategoryListToCopyItemMap,
        ]);

  @override
  ViewModel fromStore() => ViewModel.build(
        infoCategoryListToCopyItemMap:
            state.infoCategoryState.infoCategoryListToCopyItemMap,
        onSetCopyItemMapInInfoCategory: (InfoCategoryModel infoCategoryModel) {
          dispatch(SetCopyItemMapInInfoCategorySyncInfoCategoryAction(
              infoCategoryModel: infoCategoryModel));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoCategorySelectToCopyItemMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      onInit: (store) {
        store.dispatch(
            GetDocsInfoCategoryListToCopyItemMapAsyncInfoCategoryAction());
      },
      builder: (context, viewModel) => InfoCategorySelectToCopyItemMapDS(
        infoCategoryListToCopyItemMap: viewModel.infoCategoryListToCopyItemMap,
        onSetCopyItemMapInInfoCategory:
            viewModel.onSetCopyItemMapInInfoCategory,
      ),
    );
  }
}
