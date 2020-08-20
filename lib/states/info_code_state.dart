import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/types_states.dart';
import 'package:meta/meta.dart';

@immutable
class InfoCodeState {
  final List<InfoCodeModel> infoCodeList;
  final InfoCodeModel infoCodeCurrent;
  final InfoCodeOrder infoCodeOrder;
  InfoCodeState({
    this.infoCodeList,
    this.infoCodeCurrent,
    this.infoCodeOrder,
  });
  factory InfoCodeState.initialState() => InfoCodeState(
        infoCodeList: <InfoCodeModel>[],
        infoCodeCurrent: null,
        infoCodeOrder: InfoCodeOrder.code,
      );
  InfoCodeState copyWith({
    List<InfoCodeModel> infoCodeList,
    InfoCodeModel infoCodeCurrent,
    InfoCodeOrder infoCodeOrder,
  }) =>
      InfoCodeState(
        infoCodeList: infoCodeList ?? this.infoCodeList,
        infoCodeCurrent: infoCodeCurrent ?? this.infoCodeCurrent,
        infoCodeOrder: infoCodeOrder ?? this.infoCodeOrder,
      );
  @override
  int get hashCode =>
      infoCodeList.hashCode ^ infoCodeCurrent.hashCode ^ infoCodeOrder.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoCodeState &&
          infoCodeOrder == other.infoCodeOrder &&
          infoCodeList == other.infoCodeList &&
          infoCodeCurrent == other.infoCodeCurrent &&
          runtimeType == other.runtimeType;
}
