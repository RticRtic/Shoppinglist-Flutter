import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist_provider/providers/itemCounter_greens.dart';
import 'package:shoppinglist_provider/screens/shoppinglist_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ItemCounterGreens())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: "/",
      // routes: {"/": (context) => const ShoppingListScreen()},
      theme: ThemeData(
        fontFamily: "Times",
      ),
      debugShowCheckedModeBanner: false,
      home: const ShoppingListScreen(),
    );
  }
}
