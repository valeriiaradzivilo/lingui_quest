import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';

part 'generated/group_model.freezed.dart';
part 'generated/group_model.g.dart';

@freezed
class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String creatorId,
    required String name,
    required String description,
    required String code,
    required List<String> students,
  }) = _GroupModel;
  factory GroupModel.fromJson(Json json) => _$GroupModelFromJson(json);

  factory GroupModel.empty() {
    return GroupModel(
      creatorId: '',
      name: '',
      description: '',
      students: [],
      code: '',
    );
  }

  const GroupModel._();
}
