import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zavisoft_flutter_task/core/network/api_client.dart';
import 'package:zavisoft_flutter_task/core/theme/app_theme.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_bloc.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/bloc/home_event.dart';
import 'package:zavisoft_flutter_task/features/home/presentation/screens/home_screen.dart';
import 'package:zavisoft_flutter_task/features/products/data/product_repository.dart';
import 'package:zavisoft_flutter_task/features/products/presentation/bloc/products_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()..add(ChangeNavIndexEvent(index: 0)),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(
            repository: ProductRepository(apiClient: ApiClient()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZaviSoft Task',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            surface: AppColors.backgroundLight,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: AppColors.backgroundLight,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.nonactiveNavColor,
          ),
        ),

        themeMode: ThemeMode.light,
        home: const HomeScreen(),
      ),
    );
  }
}
