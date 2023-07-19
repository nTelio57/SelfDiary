import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Widget body()
  {
    return Stack(
      children: [
        background(),
        //logo(),
        buttonsColumn()
      ],
    );
  }

  Widget background()
  {
    return Container(
      color: Theme.of(context).primaryColor,
    );
  }

  /*Widget logo()
  {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('assets/logo/v2.png'),
            width: 75,
          ),
          const Text(
            'ouser',
            style: TextStyle(
              fontSize: 65,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }*/

  Widget buttonsColumn()
  {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 175),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          whiteTextButton('Prisijungti', onLoginClicked),
        ],
      ),
    );
  }

  Widget whiteTextButton(String text, Function() handler)
  {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
          onPressed: handler,
          child: Text(
              text,
            style: const TextStyle(
              fontSize: 18
            ),
          ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white
        )
      ),
    );
  }
  
  void onLoginClicked()
  {
    if (kDebugMode) {
      print('Login clicked');
    }
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
    signInWithGoogle();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    final user = FirebaseAuth.instance.currentUser;
    if(user != null)
      {
        print(FirebaseAuth.instance.currentUser?.uid);
        for (final providerProfile in user.providerData) {
          // ID of the provider (google.com, apple.com, etc.)
          final provider = providerProfile.providerId;

          // UID specific to the provider
          final uid = providerProfile.uid;

          // Name, email address, and profile photo URL
          final name = providerProfile.displayName;
          final emailAddress = providerProfile.email;
          final profilePhoto = providerProfile.photoURL;
          print(user.displayName);
          print(emailAddress);
          print(profilePhoto);
        }
      }
  }
}
