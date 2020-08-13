import 'package:indis/models/info_ind_owner_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoIndOwnerState {
  final List<InfoIndOwnerModel> infoIndOwnerList;
  final InfoIndOwnerModel infoIndOwnerCurrent;
  InfoIndOwnerState({
    this.infoIndOwnerList,
    this.infoIndOwnerCurrent,
  });
  factory InfoIndOwnerState.initialState() => InfoIndOwnerState(
        infoIndOwnerList: <InfoIndOwnerModel>[],
        infoIndOwnerCurrent: null,
      );
  InfoIndOwnerState copyWith({
    List<InfoIndOwnerModel> infoIndOwnerList,
    InfoIndOwnerModel infoIndOwnerCurrent,
  }) =>
      InfoIndOwnerState(
        infoIndOwnerList: infoIndOwnerList ?? this.infoIndOwnerList,
        infoIndOwnerCurrent: infoIndOwnerCurrent ?? this.infoIndOwnerCurrent,
      );
  @override
  int get hashCode => infoIndOwnerList.hashCode ^ infoIndOwnerCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoIndOwnerState &&
          infoIndOwnerList == other.infoIndOwnerList &&
          infoIndOwnerCurrent == other.infoIndOwnerCurrent &&
          runtimeType == other.runtimeType;
}
