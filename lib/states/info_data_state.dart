import 'package:indis/models/info_setor_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoSetorState {
  final List<InfoSetorModel> infoSetorList;
  final InfoSetorModel infoSetorCurrent;
  // final List<InfoSetorSourceField> infoSetorSourceFieldList;
  // final InfoSetorSourceField infoSetorSourceFieldCurrent;
  InfoSetorState({
    this.infoSetorList,
    this.infoSetorCurrent,
    // this.infoSetorSourceFieldList,
    // this.infoSetorSourceFieldCurrent,
  });
  factory InfoSetorState.initialState() => InfoSetorState(
        infoSetorList: <InfoSetorModel>[],
        infoSetorCurrent: null,
        // infoSetorSourceFieldList: <InfoSetorSourceField>[],
        // infoSetorSourceFieldCurrent: null,
      );
  InfoSetorState copyWith({
    List<InfoSetorModel> infoSetorList,
    InfoSetorModel infoSetorCurrent,
    // List<InfoSetorSourceField> infoSetorSourceFieldList,
    // InfoSetorModel infoSetorSourceFieldCurrent,
  }) =>
      InfoSetorState(
        infoSetorList: infoSetorList ?? this.infoSetorList,
        infoSetorCurrent: infoSetorCurrent ?? this.infoSetorCurrent,
        // infoSetorSourceFieldList:
        //     infoSetorSourceFieldList ?? this.infoSetorSourceFieldList,
        // infoSetorSourceFieldCurrent:
        //     infoSetorSourceFieldCurrent ?? this.infoSetorSourceFieldCurrent,
      );
  @override
  int get hashCode =>
      // infoSetorSourceFieldCurrent.hashCode ^
      // infoSetorSourceFieldList.hashCode ^
      infoSetorList.hashCode ^ infoSetorCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoSetorState &&
          // infoSetorSourceFieldCurrent == other.infoSetorSourceFieldCurrent &&
          // infoSetorSourceFieldList == other.infoSetorSourceFieldList &&
          infoSetorList == other.infoSetorList &&
          infoSetorCurrent == other.infoSetorCurrent &&
          runtimeType == other.runtimeType;
}
