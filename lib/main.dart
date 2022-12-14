import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/providers/chatProvider.dart';
import 'package:flash_chat/screens/add_chat.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chats_screen.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ChatProvider()),
    ],
    child: const FlashChat(),
  ));

}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        AddChat.id:(context)=>AddChat(),
        WelcomeScreen.id:(context) =>const WelcomeScreen(),
        LoginScreen.id:(context) =>const LoginScreen(),
        RegistrationScreen.id:(context) =>const RegistrationScreen(),
        ChatsScreen.id:(context) =>const ChatsScreen(),
      },
    );
  }
}
