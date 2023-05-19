// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'animations_data.g.dart';

@collection
class AnimationData {
  Id id = Isar.autoIncrement;
  String? path;
  String? artboard;
  String? stateMachine;
  String? trigger;

  bool get isConfigured =>
      artboard != null && stateMachine != null && trigger != null;

  @override
  bool operator ==(covariant AnimationData other) {
    if (identical(this, other)) return true;

    return other.id == id && other.path == path;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        path.hashCode ^
        artboard.hashCode ^
        stateMachine.hashCode ^
        trigger.hashCode;
  }

  @override
  String toString() {
    return 'AnimationData(id: $id, path: $path, artboard: $artboard, stateMachine: $stateMachine, trigger: $trigger)';
  }
}
