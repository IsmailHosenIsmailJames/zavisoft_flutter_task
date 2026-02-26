import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_event.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_state.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/widget/home_nav_bar.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/screens/products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: context.read<HomeBloc>().state.selectedNavIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.selectedNavIndex != current.selectedNavIndex,
      listener: (context, state) {
        if (_pageController.hasClients &&
            _pageController.page?.round() != state.selectedNavIndex) {
          _pageController.jumpToPage(state.selectedNavIndex);
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            context.read<HomeBloc>().add(ChangeNavIndexEvent(index: index));
          },
          children: const <Widget>[
            ProductsScreen(),
            Center(child: Text('Message')),
            Center(child: Text('Cart')),
            Center(child: Text('Profile')),
          ],
        ),
        bottomNavigationBar: const HomeNavBar(),
      ),
    );
  }
}
