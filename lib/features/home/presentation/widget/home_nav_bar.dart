import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_event.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_state.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.selectedNavIndex,
          onTap: (index) {
            context.read<HomeBloc>().add(ChangeNavIndexEvent(index: index));
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Badge(label: Text('1'), child: Icon(Icons.message)),
              label: 'Message',
            ),
            BottomNavigationBarItem(
              icon: Badge(label: Text('3'), child: Icon(Icons.shopping_cart)),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
