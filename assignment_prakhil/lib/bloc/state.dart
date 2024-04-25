import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  const DataState();
}

class DataInitial extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoaded extends DataState {
  final List<String> images;

  DataLoaded(this.images);

  @override
  List<Object?> get props => [images];
}

class DarkModeChanged extends DataState {
  final bool isDarkMode;

  DarkModeChanged(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}
