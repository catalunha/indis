import 'package:indis/models/info_setor_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoSetorState {
  final List<InfoSetorModel> infoSetorList;
  final InfoSetorModel infoSetorCurrent;
  final List<InfoSetorSourceModel> infoSetorSourceList;
  final InfoSetorSourceModel infoSetorSourceCurrent;
  final InfoSetorValueModel infoSetorValueCurrent;
  final List<InfoSetorValueDataModel> infoSetorValueDataList;
  final InfoSetorValueDataModel infoSetorValueDataCurrent;
  InfoSetorState({
    this.infoSetorList,
    this.infoSetorCurrent,
    this.infoSetorSourceList,
    this.infoSetorSourceCurrent,
    this.infoSetorValueCurrent,
    this.infoSetorValueDataList,
    this.infoSetorValueDataCurrent,
  });
  factory InfoSetorState.initialState() => InfoSetorState(
        infoSetorList: <InfoSetorModel>[],
        infoSetorCurrent: null,
        infoSetorSourceList: <InfoSetorSourceModel>[],
        infoSetorSourceCurrent: null,
        infoSetorValueCurrent: null,
        infoSetorValueDataList: <InfoSetorValueDataModel>[],
        infoSetorValueDataCurrent: null,
      );
  InfoSetorState copyWith({
    List<InfoSetorModel> infoSetorList,
    InfoSetorModel infoSetorCurrent,
    List<InfoSetorSourceModel> infoSetorSourceList,
    InfoSetorSourceModel infoSetorSourceCurrent,
    InfoSetorValueModel infoSetorValueCurrent,
    List<InfoSetorValueDataModel> infoSetorValueDataList,
    InfoSetorValueDataModel infoSetorValueDataCurrent,
  }) =>
      InfoSetorState(
        infoSetorValueDataCurrent:
            infoSetorValueDataCurrent ?? this.infoSetorValueDataCurrent,
        infoSetorValueDataList:
            infoSetorValueDataList ?? this.infoSetorValueDataList,
        infoSetorList: infoSetorList ?? this.infoSetorList,
        infoSetorCurrent: infoSetorCurrent ?? this.infoSetorCurrent,
        infoSetorValueCurrent:
            infoSetorValueCurrent ?? this.infoSetorValueCurrent,
        infoSetorSourceList: infoSetorSourceList ?? this.infoSetorSourceList,
        infoSetorSourceCurrent:
            infoSetorSourceCurrent ?? this.infoSetorSourceCurrent,
      );
  @override
  int get hashCode =>
      infoSetorValueCurrent.hashCode ^
      infoSetorValueDataCurrent.hashCode ^
      infoSetorValueDataList.hashCode ^
      infoSetorSourceCurrent.hashCode ^
      infoSetorSourceList.hashCode ^
      infoSetorList.hashCode ^
      infoSetorCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoSetorState &&
          infoSetorValueCurrent == other.infoSetorValueCurrent &&
          infoSetorValueDataCurrent == other.infoSetorValueDataCurrent &&
          infoSetorValueDataList == other.infoSetorValueDataList &&
          infoSetorSourceCurrent == other.infoSetorSourceCurrent &&
          infoSetorSourceList == other.infoSetorSourceList &&
          infoSetorList == other.infoSetorList &&
          infoSetorCurrent == other.infoSetorCurrent &&
          runtimeType == other.runtimeType;
}
