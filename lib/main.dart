import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/core/common/cubits/app/app_cubit.dart';
import 'package:flutter_bloc_clean_architecture/core/theme/theme.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/bloc/auth_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/auth/ui/pages/login.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/ui/pages/blog_page.dart';
import 'package:flutter_bloc_clean_architecture/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => sl<AppCubit>()),
      BlocProvider(create: (_) => sl<AuthBloc>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clean architecture',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeModeDark(context: context),
      home: BlocSelector<AppCubit, AppState, bool>(selector: (state) {
        return state is AppLoggedIn;
      }, builder: (context, state) {
        if(state==true){
          return const BlogPage();
        }
        return const LoginPage();
      }),
    );
  }
}
