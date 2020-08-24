import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String uf;
  String city;
  String area;
  String code;
  String description;
  bool public;
  bool isCreateOrUpdate;
  Function(String, String, String, String, String, bool) onCreate;
  Function(String, String, String, String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.uf,
    @required this.city,
    @required this.area,
    @required this.code,
    @required this.description,
    @required this.public,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          uf,
          city,
          area,
          code,
          description,
          public,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate: state.infoSetorState.infoSetorCurrent.id == null,
        uf: state.infoSetorState.infoSetorCurrent.uf,
        city: state.infoSetorState.infoSetorCurrent.city,
        area: state.infoSetorState.infoSetorCurrent.area,
        code: state.infoSetorState.infoSetorCurrent.code,
        description: state.infoSetorState.infoSetorCurrent.description,
        public: state.infoSetorState.infoSetorCurrent.public ?? false,
        onCreate: (String uf, String city, String area, String code,
            String description, bool public) {
          dispatch(CreateDocInfoDataCurrentAsyncInfoSetorAction(
            uf: uf,
            city: city,
            area: area,
            code: code,
            description: description,
            public: public,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String uf, String city, String area, String code,
            String description, bool public) {
          dispatch(UpdateDocInfoDataCurrentAsyncInfoSetorAction(
            uf: uf,
            city: city,
            area: area,
            code: code,
            description: description,
            public: public,
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
        uf: viewModel.uf,
        city: viewModel.city,
        area: viewModel.area,
        code: viewModel.code,
        description: viewModel.description,
        public: viewModel.public,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
