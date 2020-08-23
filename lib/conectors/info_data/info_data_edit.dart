import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_data_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_data/info_data_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String uf;
  String city;
  String area;
  String code;
  String description;
  bool isCreateOrUpdate;
  Function(String, String, String, String, String) onCreate;
  Function(String, String, String, String, String) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.code,
    @required this.description,
    @required this.uf,
    @required this.city,
    @required this.area,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          code,
          description,
          uf,
          city,
          area,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate: state.infoSetorState.infoSetorCurrent.id == null,
        code: state.infoSetorState.infoSetorCurrent.code,
        description: state.infoSetorState.infoSetorCurrent.description,
        uf: state.infoSetorState.infoSetorCurrent.uf,
        city: state.infoSetorState.infoSetorCurrent.city,
        area: state.infoSetorState.infoSetorCurrent.area,
        onCreate: (String uf, String city, String area, String code,
            String description) {
          dispatch(CreateDocInfoDataCurrentAsyncInfoSetorAction(
            code: code,
            description: description,
            uf: uf,
            city: city,
            area: area,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String uf, String city, String area, String code,
            String description) {
          dispatch(UpdateDocInfoDataCurrentAsyncInfoSetorAction(
            code: code,
            description: description,
            uf: uf,
            city: city,
            area: area,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoSetorEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        code: viewModel.code,
        description: viewModel.description,
        uf: viewModel.uf,
        city: viewModel.city,
        area: viewModel.area,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
