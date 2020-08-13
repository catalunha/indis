import 'package:indis/models/info_code_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoCodeState {
  final List<InfoCodeModel> infoCodeList;
  final InfoCodeModel infoCodeCurrent;
  InfoCodeState({
    this.infoCodeList,
    this.infoCodeCurrent,
  });
  factory InfoCodeState.initialState() => InfoCodeState(
        infoCodeList: <InfoCodeModel>[],
        infoCodeCurrent: null,
      );
  InfoCodeState copyWith({
    List<InfoCodeModel> infoCodeList,
    InfoCodeModel infoCodeCurrent,
  }) =>
      InfoCodeState(
        infoCodeList: infoCodeList ?? this.infoCodeList,
        infoCodeCurrent: infoCodeCurrent ?? this.infoCodeCurrent,
      );
  @override
  int get hashCode => infoCodeList.hashCode ^ infoCodeCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoCodeState &&
          infoCodeList == other.infoCodeList &&
          infoCodeCurrent == other.infoCodeCurrent &&
          runtimeType == other.runtimeType;
}
