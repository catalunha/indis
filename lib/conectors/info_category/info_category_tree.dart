import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_tree_ds.dart';

class ViewModel extends BaseModel<AppState> {
  Map<String, CategoryData> categoryDataMap;
  ViewModel();
  ViewModel.build({
    @required this.categoryDataMap,
  }) : super(equals: [categoryDataMap]);
  @override
  ViewModel fromStore() => ViewModel.build(
      categoryDataMap:
          state.infoCategoryState.infoCategoryCurrent.categoryDataMap);
}

class InfoCategoryTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryTreeDS(
        categoryDataMap: viewModel.categoryDataMap,
      ),
    );
  }
}
