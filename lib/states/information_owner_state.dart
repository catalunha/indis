import 'package:indis/models/information_owner_model.dart';
import 'package:meta/meta.dart';

@immutable
class InformationOwnerState {
  final List<InformationOwnerModel> informationOwnerList;
  final InformationOwnerModel informationOwnerCurrent;
  InformationOwnerState({
    this.informationOwnerList,
    this.informationOwnerCurrent,
  });
  factory InformationOwnerState.initialState() => InformationOwnerState(
        informationOwnerList: <InformationOwnerModel>[],
        informationOwnerCurrent: null,
      );
  InformationOwnerState copyWith({
    List<InformationOwnerModel> informationOwnerList,
    InformationOwnerModel informationOwnerCurrent,
  }) =>
      InformationOwnerState(
        informationOwnerList: informationOwnerList ?? this.informationOwnerList,
        informationOwnerCurrent:
            informationOwnerCurrent ?? this.informationOwnerCurrent,
      );
  @override
  int get hashCode =>
      informationOwnerList.hashCode ^ informationOwnerCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InformationOwnerState &&
          informationOwnerList == other.informationOwnerList &&
          informationOwnerCurrent == other.informationOwnerCurrent &&
          runtimeType == other.runtimeType;
}
