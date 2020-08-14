import 'package:indis/models/info_ind_organizer_model.dart';
import 'package:meta/meta.dart';

@immutable
class InfoIndOrganizerState {
  final List<InfoIndOrganizerModel> infoIndOrganizerList;
  final InfoIndOrganizerModel infoIndOrganizerCurrent;
  InfoIndOrganizerState({
    this.infoIndOrganizerList,
    this.infoIndOrganizerCurrent,
  });
  factory InfoIndOrganizerState.initialState() => InfoIndOrganizerState(
        infoIndOrganizerList: <InfoIndOrganizerModel>[],
        infoIndOrganizerCurrent: null,
      );
  InfoIndOrganizerState copyWith({
    List<InfoIndOrganizerModel> infoIndOrganizerList,
    InfoIndOrganizerModel infoIndOrganizerCurrent,
  }) =>
      InfoIndOrganizerState(
        infoIndOrganizerList: infoIndOrganizerList ?? this.infoIndOrganizerList,
        infoIndOrganizerCurrent:
            infoIndOrganizerCurrent ?? this.infoIndOrganizerCurrent,
      );
  @override
  int get hashCode =>
      infoIndOrganizerList.hashCode ^ infoIndOrganizerCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoIndOrganizerState &&
          infoIndOrganizerList == other.infoIndOrganizerList &&
          infoIndOrganizerCurrent == other.infoIndOrganizerCurrent &&
          runtimeType == other.runtimeType;
}
