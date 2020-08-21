import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/actions/info_ind_owner_action.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_ind_owner/info_ind_owner_select_to_infocategory_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoIndOwnerModel> infoIndOwnerList;
  Function(String) onSetInfoIndOwnerInInfoCategory;
  ViewModel();
  ViewModel.build({
    @required this.infoIndOwnerList,
    @required this.onSetInfoIndOwnerInInfoCategory,
  }) : super(equals: [
          infoIndOwnerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoIndOwnerList: state.infoIndOwnerState.infoIndOwnerList,
        onSetInfoIndOwnerInInfoCategory: (String infoIndOwnerCode) {
          dispatch(SetInfoIndOwnerInInfoCategorySyncInfoCategoryAction(
              infoIndOwnerCode: infoIndOwnerCode));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoindOwnerSelectToInfoCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction()),
      builder: (context, viewModel) => InfoindOwnerSelectToInfoCategoryDS(
        infoIndOwnerList: viewModel.infoIndOwnerList,
        onSetInfoIndOwnerInInfoCategory:
            viewModel.onSetInfoIndOwnerInInfoCategory,
      ),
    );
  }
}
