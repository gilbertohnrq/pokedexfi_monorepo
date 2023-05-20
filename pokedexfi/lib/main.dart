import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/dependencies/service_locator.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Locator().initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedexfi',
        theme: ThemeData(
          primaryColor: DexColors.primary,
          appBarTheme: const AppBarTheme(
            backgroundColor: DexColors.primary,
            elevation: 0,
          ),
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: Routes.listPage.route,
      ),
    );
  }
}
