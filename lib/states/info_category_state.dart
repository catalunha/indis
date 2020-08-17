import 'package:indis/models/info_category_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoCategoryState {
  final List<InfoCategoryModel> infoCategoryList;
  final InfoCategoryModel infoCategoryCurrent;
  final CategoryData infoCategoryDataCurrent;
  InfoCategoryState({
    this.infoCategoryList,
    this.infoCategoryCurrent,
    this.infoCategoryDataCurrent,
  });
  factory InfoCategoryState.initialState() => InfoCategoryState(
        infoCategoryList: <InfoCategoryModel>[],
        infoCategoryCurrent: null,
        infoCategoryDataCurrent: null,
      );
  InfoCategoryState copyWith({
    List<InfoCategoryModel> infoCategoryList,
    InfoCategoryModel infoCategoryCurrent,
    CategoryData infoCategoryDataCurrent,
  }) =>
      InfoCategoryState(
        infoCategoryList: infoCategoryList ?? this.infoCategoryList,
        infoCategoryCurrent: infoCategoryCurrent ?? this.infoCategoryCurrent,
        infoCategoryDataCurrent:
            infoCategoryDataCurrent ?? this.infoCategoryDataCurrent,
      );
  @override
  int get hashCode =>
      infoCategoryList.hashCode ^
      infoCategoryCurrent.hashCode ^
      infoCategoryDataCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoCategoryState &&
          infoCategoryDataCurrent == other.infoCategoryDataCurrent &&
          infoCategoryList == other.infoCategoryList &&
          infoCategoryCurrent == other.infoCategoryCurrent &&
          runtimeType == other.runtimeType;
}
