import 'package:async_redux/async_redux.dart';
import 'package:indis/states/info_ind_owner_state.dart';
import 'package:indis/states/logged_state.dart';
import 'package:indis/states/user_state.dart';

class AppState {
  final Wait wait;
  final LoggedState loggedState;
  final UserState userState;
  final InfoIndOwnerState infoIndOwnerState;

  AppState({
    this.wait,
    this.loggedState,
    this.userState,
    this.infoIndOwnerState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        infoIndOwnerState: InfoIndOwnerState.initialState(),
      );
  AppState copyWith({
    Wait wait,
    LoggedState loggedState,
    UserState userState,
    InfoIndOwnerState infoIndOwnerState,
  }) =>
      AppState(
        wait: wait ?? this.wait,
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        infoIndOwnerState: infoIndOwnerState ?? this.infoIndOwnerState,
      );
  @override
  int get hashCode =>
      loggedState.hashCode ^
      userState.hashCode ^
      wait.hashCode ^
      infoIndOwnerState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          infoIndOwnerState == other.infoIndOwnerState &&
          userState == other.userState &&
          loggedState == other.loggedState &&
          wait == other.wait &&
          runtimeType == other.runtimeType;
}
