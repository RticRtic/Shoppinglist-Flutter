import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/providers/streambuilders/streambuilder_categorie_items.dart';
import 'package:shoppinglist_provider/widgets/modalbottomsheet.dart';

class ItemsInCategorieScreen extends StatefulWidget {
  final String categorie;
  final int index;
  bool backToShoppingListCategorie = false;
  ItemsInCategorieScreen(
      {super.key,
      required this.categorie,
      required this.index,
      required this.backToShoppingListCategorie});

  @override
  State<ItemsInCategorieScreen> createState() => _ItemsInCategorieScreenState();
}

class _ItemsInCategorieScreenState extends State<ItemsInCategorieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 50.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.backToShoppingListCategorie;
                });
              },
              child: const Icon(Icons.toc),
            ),
          )
        ],
        title: Text(widget.categorie),
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
          child: CategorieStreamBuilderItems(
            index: widget.index,
            categorieDoc: widget.categorie,
            showUpdateItemForm: widget.backToShoppingListCategorie,
          )),
      floatingActionButton: ModalBottomSheet(
        index: widget.index,
        categorieTitle: widget.categorie,
      ),
    );
  }
}
