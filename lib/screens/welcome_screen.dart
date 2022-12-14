import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/providers/chatProvider.dart';
import 'package:flash_chat/screens/chats_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/widgets//rounded_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  const WelcomeScreen({super.key});
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.redAccent)
        .animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit && FirebaseAuth.instance.currentUser != null) {
      isInit = true;
      Future.delayed(const Duration(microseconds: 1)).then((value) {
        Provider.of<ChatProvider>(context, listen: false)
            .init(FirebaseAuth.instance.currentUser!.email!);
        Navigator.pushReplacementNamed(context, ChatsScreen.id);
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: isInit
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Hero(
                            tag: 'flash',
                            child: Container(
                                height: 80,
                                child: Image.asset('images/logo.png')),
                          ),
                          DefaultTextStyle(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'Flash Chat',
                                  speed: const Duration(
                                    milliseconds: 300,
                                  ),
                                ),
                              ],
                              repeatForever: true,
                            ),
                            style: const TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      RoundedButton(
                          text: 'LogIn',
                          color: Colors.blueAccent,
                          onPressed: () =>
                              Navigator.pushNamed(context, LoginScreen.id)),
                      const SizedBox(
                        height: 12,
                      ),
                      RoundedButton(
                          text: 'Register',
                          color: Colors.blueAccent,
                          onPressed: () => Navigator.pushNamed(
                              context, RegistrationScreen.id)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
