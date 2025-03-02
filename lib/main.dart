import 'package:contact_repertory/screens/contact_list.dart';
import 'package:contact_repertory/screens/login.dart';
import 'package:contact_repertory/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/Contacts_Provider.dart';
import 'Providers/auth_provider.dart';

void main() async{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
     ChangeNotifierProvider(create: (_) => ContactProvider()..fetchContacts()),

    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repertoire',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return authProvider.isAuthenticated ? ContactListScreen() : LoginScreen();
        },
      ),
    );

  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
    );
  }
}
