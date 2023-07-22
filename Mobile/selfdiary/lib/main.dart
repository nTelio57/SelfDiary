import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selfdiary/resources/app_colors.dart';
import 'package:selfdiary/ui/views/HomeView.dart';
import 'package:selfdiary/welcome_view.dart';
import './ui/router.dart' as UIRouter;
import 'core/viewmodels/CRUDModel.dart';
import 'firebase_options.dart';
import 'locator.dart';

Widget _initialRoute = const WelcomeView();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  await ensureLoggedIn();
  runApp(const MyApp());
}

Future ensureLoggedIn() async{
  final user = FirebaseAuth.instance.currentUser;
  if(user != null)
  {
    print(FirebaseAuth.instance.currentUser?.uid);
    _initialRoute = HomeView();
  }
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
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: '/',
        home: _initialRoute,
        onGenerateRoute: UIRouter.Router.generateRoute,
      ),
    );
  }
}
