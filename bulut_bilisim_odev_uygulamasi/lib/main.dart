import 'core/init/providers.dart';
import 'core/routes/router.dart';
import 'core/routes/routes.dart';
import 'core/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: Providers.getProviders,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CRouter.generateRoute,
      initialRoute: Routes.LOGIN,
      title: 'BulutBilisimOdev',
      theme: CustomTheme.instance.apptheme,
    );
  }
}
