import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_tree_ds.dart';

class ViewModel extends BaseModel<AppState> {
  Map<String, CategoryData> categoryDataMap;
  Function(String, bool) onEditInfoCategoryDataCurrent;

  ViewModel();
  ViewModel.build({
    @required this.categoryDataMap,
    @required this.onEditInfoCategoryDataCurrent,
  }) : super(equals: [categoryDataMap]);
  @override
  ViewModel fromStore() => ViewModel.build(
        categoryDataMap:
            state.infoCategoryState.infoCategoryCurrent.categoryDataMap,
        onEditInfoCategoryDataCurrent: (String id, bool isCreateOrUpdate) {
          dispatch(SetInfoCategoryDataCurrentSyncInfoCategoryAction(
              id: id, isCreateOrUpdate: isCreateOrUpdate));
          dispatch(NavigateAction.pushNamed(Routes.infoCategoryDataEdit));
        },
      );
}

class InfoCategoryTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryTreeDS(
        categoryDataMap: viewModel.categoryDataMap,
        onEditInfoCategoryDataCurrent: viewModel.onEditInfoCategoryDataCurrent,
      ),
    );
  }
}
