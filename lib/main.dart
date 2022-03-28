import 'package:ebook_uploader/screens/login_screen/login_screen.dart';
import 'package:ebook_uploader/screens/uploader_screen/uploader_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebook_uploader/bloc/bloc.dart';
import 'package:ebook_uploader/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Starting...');
    return BlocProvider(
      create: (_) => AppBloc()..add(const AppOpened()),
      child: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eBook Uploader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const UploaderScreen(),
        '/login': (context) => const LoginMain(),
      },
    );
  }
}
