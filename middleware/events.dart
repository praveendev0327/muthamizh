
import 'package:equatable/equatable.dart';

abstract class StringEvent extends Equatable {
  const StringEvent();

  @override
  List<Object> get props => [];
}

class SetString extends StringEvent {
  final String value;

  const SetString(this.value);

  @override
  List<Object> get props => [value];
}
