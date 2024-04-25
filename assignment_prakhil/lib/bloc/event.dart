import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}

class FetchData extends DataEvent {
  @override
  List<Object?> get props => [];
}

class ToggleDarkMode extends DataEvent {
  @override
  List<Object?> get props => [];
}
