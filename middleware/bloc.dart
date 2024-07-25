
import 'package:muthamizh/middleware/events.dart';
import 'package:muthamizh/middleware/state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class StringBloc extends Bloc<StringEvent, StringState> {
  StringBloc() : super(StringInitial()) {
    on<SetString>((event, emit) {
      emit(StringLoaded(event.value));
    });
  }
}
