import 'package:indis/models/info_setor_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoDataState {
  final List<InfoSetorModel> infoDataList;
  final InfoSetorModel infoDataCurrent;
  final List<InfoDataSourceField> infoDataSourceFieldList;
  final InfoDataSourceField infoDataSourceFieldCurrent;
  InfoDataState({
    this.infoDataList,
    this.infoDataCurrent,
    this.infoDataSourceFieldList,
    this.infoDataSourceFieldCurrent,
  });
  factory InfoDataState.initialState() => InfoDataState(
        infoDataList: <InfoSetorModel>[],
        infoDataCurrent: null,
        infoDataSourceFieldList: <InfoDataSourceField>[],
        infoDataSourceFieldCurrent: null,
      );
  InfoDataState copyWith({
    List<InfoSetorModel> infoDataList,
    InfoSetorModel infoDataCurrent,
    List<InfoDataSourceField> infoDataSourceFieldList,
    InfoSetorModel infoDataSourceFieldCurrent,
  }) =>
      InfoDataState(
        infoDataList: infoDataList ?? this.infoDataList,
        infoDataCurrent: infoDataCurrent ?? this.infoDataCurrent,
        infoDataSourceFieldList:
            infoDataSourceFieldList ?? this.infoDataSourceFieldList,
        infoDataSourceFieldCurrent:
            infoDataSourceFieldCurrent ?? this.infoDataSourceFieldCurrent,
      );
  @override
  int get hashCode =>
      infoDataSourceFieldCurrent.hashCode ^
      infoDataSourceFieldList.hashCode ^
      infoDataList.hashCode ^
      infoDataCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoDataState &&
          infoDataSourceFieldCurrent == other.infoDataSourceFieldCurrent &&
          infoDataSourceFieldList == other.infoDataSourceFieldList &&
          infoDataList == other.infoDataList &&
          infoDataCurrent == other.infoDataCurrent &&
          runtimeType == other.runtimeType;
}
