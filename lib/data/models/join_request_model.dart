import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lingui_quest/core/helper/serializable_interface.dart';
import 'package:lingui_quest/data/models/join_request_full_model.dart';

part 'generated/join_request_model.freezed.dart';
part 'generated/join_request_model.g.dart';

@freezed
class JoinRequestModel with _$JoinRequestModel {
  const factory JoinRequestModel({
    required String groupId,
    required String userId,
    required String id,
    @JsonKey(
      fromJson: fromTimestamp,
      toJson: Timestamp.fromDate,
    )
    required DateTime requestDate,
  }) = _JoinRequestModel;
  factory JoinRequestModel.fromJson(Json json) => _$JoinRequestModelFromJson(json);

  factory JoinRequestModel.empty() {
    return JoinRequestModel(
      groupId: '',
      userId: '',
      id: '',
      requestDate: DateTime.now(),
    );
  }

  const JoinRequestModel._();
}
