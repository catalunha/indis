import 'package:indis/models/info_category_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoCategoryState {
  final List<InfoCategoryModel> infoCategoryList;
  final InfoCategoryModel infoCategoryCurrent;
  InfoCategoryState({
    this.infoCategoryList,
    this.infoCategoryCurrent,
  });
  factory InfoCategoryState.initialState() => InfoCategoryState(
        infoCategoryList: <InfoCategoryModel>[],
        infoCategoryCurrent: null,
      );
  InfoCategoryState copyWith({
    List<InfoCategoryModel> infoCategoryList,
    InfoCategoryModel infoCategoryCurrent,
  }) =>
      InfoCategoryState(
        infoCategoryList: infoCategoryList ?? this.infoCategoryList,
        infoCategoryCurrent: infoCategoryCurrent ?? this.infoCategoryCurrent,
      );
  @override
  int get hashCode => infoCategoryList.hashCode ^ infoCategoryCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoCategoryState &&
          infoCategoryList == other.infoCategoryList &&
          infoCategoryCurrent == other.infoCategoryCurrent &&
          runtimeType == other.runtimeType;
}
