import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/firebase/firebase.dart';
import 'package:shoppinglist_provider/models/catergories.dart';
import 'package:shoppinglist_provider/providers/streambuilders/streambuilder_shoppinglist_itemcounter.dart';
import 'package:shoppinglist_provider/screens/items_in_categorie_screen.dart';
import 'package:shoppinglist_provider/widgets/modalbottonsheet_categories.dart';

class CategorieGridTile extends StatefulWidget {
  const CategorieGridTile({super.key});

  @override
  State<CategorieGridTile> createState() => _CategorieGridTileState();
}

class _CategorieGridTileState extends State<CategorieGridTile> {
  final firebaseProvider = FirebaseProvider();
  final itemName = TextEditingController();
  final categories = Categories(categories: [
    "Greens",
    "Meat",
    "Dairy",
    "Taco",
    "Freezer",
    "Dry",
    "Cleaning",
    "Freshness"
  ]);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categories.categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      padding: const EdgeInsets.all(20.0),
      itemBuilder: ((context, index) {
        return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(217, 221, 240, 0.5),
                  Color.fromRGBO(239, 236, 235, 0.7)
                ],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GridTile(
              header: GridTileBar(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ItemsInCategorieScreen(
                                categorie: categories.categories[index],
                                index: index,
                                backToShoppingListCategorie: false,
                              ))));
                    },
                    child: const Icon(
                      Icons.list_alt,
                      color: Colors.black,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0))),
                          child: Center(
                            child: ShoppingListStreamBuilderItemCounter(
                              index: index,
                              categorieDoc: categories.categories[index],
                            ),
                          )),
                    ],
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ModalBottomSheetCategories(
                    categorieTitle: categories.categories[index],
                    itemName: itemName,
                    firebaseProvider: firebaseProvider,
                    index: index,
                    categorie: categories.categories[index],
                    duration: const Duration(microseconds: 100),
                  )
                ],
              ),
            ));
      }),
    );
  }
}
