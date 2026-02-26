import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeNavIndexEvent extends HomeEvent {
  const ChangeNavIndexEvent({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}
