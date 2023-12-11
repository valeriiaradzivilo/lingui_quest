import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/group_model.dart';
import 'package:lingui_quest/data/models/user_model.dart';

part 'generated/join_request_full_model.freezed.dart';
part 'generated/join_request_full_model.g.dart';

@freezed
class JoinRequestFullModel with _$JoinRequestFullModel {
  const factory JoinRequestFullModel({
    required GroupModel group,
    required UserModel user,
    required String id,
    @JsonKey(
      fromJson: fromTimestamp,
      toJson: Timestamp.fromDate,
    )
    required DateTime requestDate,
  }) = _JoinRequestFullModel;
  factory JoinRequestFullModel.fromJson(Json json) => _$JoinRequestFullModelFromJson(json);

  factory JoinRequestFullModel.empty() {
    return JoinRequestFullModel(
      group: GroupModel.empty(),
      user: UserModel.empty(),
      requestDate: DateTime.now(),
      id: '',
    );
  }

  const JoinRequestFullModel._();
}

DateTime fromTimestamp(Timestamp time) => time.toDate();
