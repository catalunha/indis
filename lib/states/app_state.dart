import 'package:async_redux/async_redux.dart';
import 'package:indis/states/information_owner_state.dart';
import 'package:indis/states/logged_state.dart';
import 'package:indis/states/user_state.dart';

class AppState {
  final Wait wait;
  final LoggedState loggedState;
  final UserState userState;
  final InformationOwnerState informationOwnerState;

  AppState({
    this.wait,
    this.loggedState,
    this.userState,
    this.informationOwnerState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        informationOwnerState: InformationOwnerState.initialState(),
      );
  AppState copyWith({
    Wait wait,
    LoggedState loggedState,
    UserState userState,
    InformationOwnerState informationOwnerState,
  }) =>
      AppState(
        wait: wait ?? this.wait,
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        informationOwnerState:
            informationOwnerState ?? this.informationOwnerState,
      );
  @override
  int get hashCode =>
      loggedState.hashCode ^
      userState.hashCode ^
      wait.hashCode ^
      informationOwnerState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          informationOwnerState == other.informationOwnerState &&
          userState == other.userState &&
          loggedState == other.loggedState &&
          wait == other.wait &&
          runtimeType == other.runtimeType;
}
