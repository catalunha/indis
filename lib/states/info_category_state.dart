import 'package:indis/models/info_category_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoCategoryState {
  final List<InfoCategoryModel> infoCategoryList;
  final InfoCategoryModel infoCategoryCurrent;
  final InfoCategoryItem infoCategoryItemCurrent;
  InfoCategoryState({
    this.infoCategoryList,
    this.infoCategoryCurrent,
    this.infoCategoryItemCurrent,
  });
  factory InfoCategoryState.initialState() => InfoCategoryState(
        infoCategoryList: <InfoCategoryModel>[],
        infoCategoryCurrent: null,
        infoCategoryItemCurrent: null,
      );
  InfoCategoryState copyWith({
    List<InfoCategoryModel> infoCategoryList,
    InfoCategoryModel infoCategoryCurrent,
    InfoCategoryItem infoCategoryItemCurrent,
  }) =>
      InfoCategoryState(
        infoCategoryList: infoCategoryList ?? this.infoCategoryList,
        infoCategoryCurrent: infoCategoryCurrent ?? this.infoCategoryCurrent,
        infoCategoryItemCurrent:
            infoCategoryItemCurrent ?? this.infoCategoryItemCurrent,
      );
  @override
  int get hashCode =>
      infoCategoryList.hashCode ^
      infoCategoryCurrent.hashCode ^
      infoCategoryItemCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoCategoryState &&
          infoCategoryItemCurrent == other.infoCategoryItemCurrent &&
          infoCategoryList == other.infoCategoryList &&
          infoCategoryCurrent == other.infoCategoryCurrent &&
          runtimeType == other.runtimeType;
}
