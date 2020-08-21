import 'package:indis/models/info_category_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoCategoryState {
  final List<InfoCategoryModel> infoCategoryList;
  final List<InfoCategoryModel> infoCategoryListToCopyItemMap;
  final InfoCategoryModel infoCategoryCurrent;
  final InfoCategoryItem infoCategoryItemCurrent;
  InfoCategoryState({
    this.infoCategoryList,
    this.infoCategoryListToCopyItemMap,
    this.infoCategoryCurrent,
    this.infoCategoryItemCurrent,
  });
  factory InfoCategoryState.initialState() => InfoCategoryState(
        infoCategoryList: <InfoCategoryModel>[],
        infoCategoryListToCopyItemMap: <InfoCategoryModel>[],
        infoCategoryCurrent: null,
        infoCategoryItemCurrent: null,
      );
  InfoCategoryState copyWith({
    List<InfoCategoryModel> infoCategoryList,
    List<InfoCategoryModel> infoCategoryListToCopyItemMap,
    InfoCategoryModel infoCategoryCurrent,
    InfoCategoryItem infoCategoryItemCurrent,
  }) =>
      InfoCategoryState(
        infoCategoryList: infoCategoryList ?? this.infoCategoryList,
        infoCategoryListToCopyItemMap:
            infoCategoryListToCopyItemMap ?? this.infoCategoryListToCopyItemMap,
        infoCategoryCurrent: infoCategoryCurrent ?? this.infoCategoryCurrent,
        infoCategoryItemCurrent:
            infoCategoryItemCurrent ?? this.infoCategoryItemCurrent,
      );
  @override
  int get hashCode =>
      infoCategoryListToCopyItemMap.hashCode ^
      infoCategoryList.hashCode ^
      infoCategoryCurrent.hashCode ^
      infoCategoryItemCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoCategoryState &&
          infoCategoryListToCopyItemMap ==
              other.infoCategoryListToCopyItemMap &&
          infoCategoryItemCurrent == other.infoCategoryItemCurrent &&
          infoCategoryList == other.infoCategoryList &&
          infoCategoryCurrent == other.infoCategoryCurrent &&
          runtimeType == other.runtimeType;
}
