// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// // Events
// abstract class StringEvent extends Equatable {
//   const StringEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class SetString extends StringEvent {
//   final String value;
//
//   SetString(this.value);
//
//   @override
//   List<Object> get props => [value];
// }
//
// // States
// abstract class StringState extends Equatable {
//   const StringState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class StringInitial extends StringState {}
//
// class StringLoaded extends StringState {
//   final String value;
//
//   StringLoaded(this.value);
//
//   @override
//   List<Object> get props => [value];
// }
//
// // BLoC
// class StringBloc extends Bloc<StringEvent, StringState> {
//   StringBloc() : super(StringInitial());
//
//   @override
//   Stream<StringState> mapEventToState(StringEvent event) async* {
//     if (event is SetString) {
//       yield StringLoaded(event.value);
//     }
//   }
// }
