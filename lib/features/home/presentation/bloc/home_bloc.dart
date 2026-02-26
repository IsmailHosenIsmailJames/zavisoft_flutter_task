import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_event.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ChangeNavIndexEvent>(_changeNavIndex);
  }

  void _changeNavIndex(ChangeNavIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedNavIndex: event.index));
  }
}
