import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wax_app/providers/settings_provider.dart';
import 'package:wax_app/screens/home.dart';
import 'package:wax_app/services/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirestoreService _db = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        StreamProvider(create: (context) => _db.getReports())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wax App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
