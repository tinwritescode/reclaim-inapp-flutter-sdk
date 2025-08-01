import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../logging/logging.dart';

part 'manual_review.g.dart';

String? _nonBlankStringFromJson(Object? o) {
  if (o is! String) return null;
  final it = o.trim();
  if (it.isEmpty) return null;
  return it;
}

enum ManualReviewPromptDisplayRule { IMMEDIATELY, NOT_LOGIN, TIMEOUT }

@JsonSerializable()
class ManualReviewActionData {
  @JsonKey(fromJson: _nonBlankStringFromJson)
  final String? message;
  @JsonKey(fromJson: _nonBlankStringFromJson)
  final String? submitLabel;
  @JsonKey(defaultValue: true)
  final bool canSubmit;
  @JsonKey(defaultValue: ManualReviewPromptDisplayRule.TIMEOUT)
  final ManualReviewPromptDisplayRule rule;
  @JsonKey(fromJson: _nonBlankStringFromJson)
  final String? confirmationDialogTitle;
  @JsonKey(fromJson: _nonBlankStringFromJson)
  final String? confirmationDialogMessage;

  static final _logging = logging.child('ManualReviewActionData');

  const ManualReviewActionData({
    required this.message,
    required this.submitLabel,
    required this.canSubmit,
    required this.rule,
    required this.confirmationDialogTitle,
    required this.confirmationDialogMessage,
  });

  factory ManualReviewActionData.fromJson(Map<String, dynamic> json) => _$ManualReviewActionDataFromJson(json);

  Map<String, dynamic> toJson() => _$ManualReviewActionDataToJson(this);

  static ManualReviewActionData? fromString(String? jsonString) {
    try {
      if (jsonString == null || jsonString.isEmpty) return null;
      final jsonMap = json.decode(jsonString);
      return ManualReviewActionData.fromJson(jsonMap);
    } catch (e, s) {
      _logging.warning('Failed to parse manual review action data', e, s);
    }
    return null;
  }

  @override
  String toString() {
    return 'ManualReviewActionData(message: $message, submitLabel: $submitLabel, canSubmit: $canSubmit, rule: $rule)';
  }
}
