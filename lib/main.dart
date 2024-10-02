import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_projetct/views/forgot_password.dart';
import 'package:firebase_projetct/views/home_page.dart';
import 'package:firebase_projetct/views/login_register.dart';
import 'package:firebase_projetct/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.grey.shade800,
          secondary: Colors.grey.shade600,
          background: Colors.grey.shade100,
          surface: Colors.grey.shade200,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
      routes: {
        '/registrarUsuario': (context) => const LoginRegister(),
        '/esqueceuSenha': (context) => const ForgotPassword(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(user: snapshot.data!);
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
