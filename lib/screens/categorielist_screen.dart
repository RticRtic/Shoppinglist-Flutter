import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/widgets/categoris_gridtile.dart';

import '../providers/streambuilders/streambuilder_itemcounter.dart';

class CategorieListScreen extends StatefulWidget {
  const CategorieListScreen({super.key});

  @override
  State<CategorieListScreen> createState() => _CategorieListScreenState();
}

class _CategorieListScreenState extends State<CategorieListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
              width: 50.0,
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      SizedBox(child: TotalItemCounter()),
                      const Icon(Icons.shopping_cart)
                    ],
                  )))
        ],
        title: const Text("Categories"),
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
        child: CategorieGridTile(),
      ),
    );
  }
}
