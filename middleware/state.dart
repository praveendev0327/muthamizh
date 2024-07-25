
import 'package:equatable/equatable.dart';

abstract class StringState extends Equatable {
  const StringState();

  @override
  List<Object> get props => [];
}

class StringInitial extends StringState {}

class StringLoaded extends StringState {
  final String value;

  const StringLoaded(this.value);

  @override
  List<Object> get props => [value];
}

