import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/resources/app_colors.dart';
import './ui/router.dart' as UIRouter;
import 'core/viewmodels/CRUDModel.dart';
import 'firebase_options.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseAuth.instanceFor(app: app);

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<CRUDModel>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primarySwatch: AppColors.primaryPalette,
          primaryColor: AppColors.primaryColor,
          fontFamily: 'OpenSans',
          textTheme: const TextTheme(
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: UIRouter.Router.generateRoute,
      ),
    );
  }
}
