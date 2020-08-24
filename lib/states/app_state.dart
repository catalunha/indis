import 'package:async_redux/async_redux.dart';
import 'package:indis/states/info_category_state.dart';
import 'package:indis/states/info_code_state.dart';
import 'package:indis/states/info_setor_state.dart';
import 'package:indis/states/info_ind_owner_state.dart';
import 'package:indis/states/logged_state.dart';
import 'package:indis/states/user_state.dart';

class AppState {
  final Wait wait;
  final LoggedState loggedState;
  final UserState userState;
  final InfoIndOwnerState infoIndOwnerState;
  final InfoCategoryState infoCategoryState;
  final InfoCodeState infoCodeState;
  final InfoSetorState infoSetorState;

  AppState({
    this.wait,
    this.loggedState,
    this.userState,
    this.infoIndOwnerState,
    this.infoCategoryState,
    this.infoCodeState,
    this.infoSetorState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        infoIndOwnerState: InfoIndOwnerState.initialState(),
        infoCategoryState: InfoCategoryState.initialState(),
        infoCodeState: InfoCodeState.initialState(),
        infoSetorState: InfoSetorState.initialState(),
      );
  AppState copyWith({
    Wait wait,
    LoggedState loggedState,
    UserState userState,
    InfoIndOwnerState infoIndOwnerState,
    InfoCategoryState infoCategoryState,
    InfoCodeState infoCodeState,
    InfoSetorState infoSetorState,
  }) =>
      AppState(
        wait: wait ?? this.wait,
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        infoIndOwnerState: infoIndOwnerState ?? this.infoIndOwnerState,
        infoCategoryState: infoCategoryState ?? this.infoCategoryState,
        infoCodeState: infoCodeState ?? this.infoCodeState,
        infoSetorState: infoSetorState ?? this.infoSetorState,
      );
  @override
  int get hashCode =>
      infoSetorState.hashCode ^
      infoCodeState.hashCode ^
      infoCategoryState.hashCode ^
      infoIndOwnerState.hashCode ^
      loggedState.hashCode ^
      userState.hashCode ^
      wait.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          infoSetorState == other.infoSetorState &&
          infoCodeState == other.infoCodeState &&
          infoCategoryState == other.infoCategoryState &&
          infoIndOwnerState == other.infoIndOwnerState &&
          userState == other.userState &&
          loggedState == other.loggedState &&
          wait == other.wait &&
          runtimeType == other.runtimeType;
}
