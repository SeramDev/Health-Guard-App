import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:health_guard/providers/auth/login_provider.dart';
import 'package:health_guard/providers/auth/signup_provider.dart';
import 'package:health_guard/providers/auth/user_provider.dart';
import 'package:health_guard/screens/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    riverpod.ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SignUpProvider()),
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          //ChangeNotifierProvider(create: (context) => FetchDataNotifier())
          /*ChangeNotifierProvider(
              create: (context) => SensorDataNotifier()), //SensorDataProvider()),
          ChangeNotifierProxyProvider<SensorDataNotifier, AlertNavigationNotifier>(
            lazy: false,
              create: (_) => AlertNavigationNotifier(),
              update: (_, parentModelInstance, dependerModelInstance) {
                return dependerModelInstance!..fetchingCounter(parentModelInstance);
              }),
              */
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'health_guard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
        background: Container(color: const Color(0xFFF5F5F5)),
      ),
    );
  }
}
