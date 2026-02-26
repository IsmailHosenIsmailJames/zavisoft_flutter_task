import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({this.selectedNavIndex = 0});

  final int selectedNavIndex;

  @override
  List<Object?> get props => [selectedNavIndex];

  HomeState copyWith({int? selectedNavIndex}) {
    return HomeState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
    );
  }
}
