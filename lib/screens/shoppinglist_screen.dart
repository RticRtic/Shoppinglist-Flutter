import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/widgets/categoris_gridtile.dart';
import 'package:shoppinglist_provider/widgets/modalbottomsheet.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
              width: 40.0,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.shopping_cart),
              ))
        ],
        title: const Text("Shoppinglist"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 3, 15, 84),
                  Color.fromARGB(255, 76, 65, 83)
                ]),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 3, 15, 84),
                Color.fromARGB(255, 223, 220, 228)
              ]),
        ),
        child: const CategorieGridTile(),
      ),
    );
  }
}
