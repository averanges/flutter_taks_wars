import 'package:json_annotation/json_annotation.dart';

part 'change_task_status_body.g.dart';

@JsonSerializable(createFactory: false)
class ChangeTaskStatusBody {
  const ChangeTaskStatusBody({required this.status});

  final int status;

  Map<String, dynamic> toJson() => _$ChangeTaskStatusBodyToJson(this);
}
