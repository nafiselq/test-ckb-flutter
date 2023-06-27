import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:karyawan_it/data/bloc/karyawan/karyawan_bloc.dart';
import 'package:karyawan_it/ui/pages/home_page.dart';
import 'package:karyawan_it/ui/pages/login_page.dart';

void main() {
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => KaryawanBloc()..add(KaryawanGet()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          // '/': (context) => const LoginPage(),
          '/': (context) => const HomePage(),
        },
      ),
    );
  }
}
