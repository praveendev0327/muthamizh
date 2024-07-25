import 'package:flutter_bloc/flutter_bloc.dart';

// Define Events
abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

// Define States
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterLoaded extends CounterState {
  final int value;
  CounterLoaded(this.value);
}

// Define BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is Increment) {
      final currentValue = (state as CounterLoaded).value;
      yield CounterLoaded(currentValue + 1);
    } else if (event is Decrement) {
      final currentValue = (state as CounterLoaded).value;
      yield CounterLoaded(currentValue - 1);
    }
  }
}
