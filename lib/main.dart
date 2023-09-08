import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/config/router/app_router.dart';

void main() async {
  //Aqui leo el archivo .env
  await Enviroment.initEnvironment();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(Enviroment.apiUrl);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
