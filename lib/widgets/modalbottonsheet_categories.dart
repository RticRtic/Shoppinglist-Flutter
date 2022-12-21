import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/models/shopping_item.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import '../firebase/firebase.dart';

class ModalBottomSheetCategories extends StatefulWidget {
  final String categorieTitle;
  final TextEditingController itemName;
  final FirebaseProvider firebaseProvider;
  final int index;
  final String categorie;
  Duration duration;

  ModalBottomSheetCategories(
      {super.key,
      required this.categorieTitle,
      required this.itemName,
      required this.firebaseProvider,
      required this.index,
      required this.categorie,
      required this.duration});

  @override
  State<ModalBottomSheetCategories> createState() =>
      _ModalBottomSheetCategoriesState();
}

class _ModalBottomSheetCategoriesState extends State<ModalBottomSheetCategories>
    with SingleTickerProviderStateMixin {
  late AnimationController localAnimationController;

  @override
  void initState() {
    super.initState();
    localAnimationController =
        AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    localAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 90.0,
                            width: 300.0,
                            child: TextField(
                              controller: widget.itemName,
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText: 'Add To ${widget.categorieTitle}',
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          ),
                          TapBounceContainer(
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.itemName.text.isEmpty) {
                                  snackbar.topSnackBarError(
                                      Overlay.of(context),
                                      "Please enter item",
                                      localAnimationController);
                                }
                                if (widget.index == 0) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else if (widget.index == 1) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else if (widget.index == 2) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else if (widget.index == 3) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else if (widget.index == 4) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else if (widget.index == 5) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else if (widget.index == 6) {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                } else {
                                  widget.firebaseProvider.addItem(
                                    ShoppingItem(name: widget.itemName.text),
                                    widget.itemName.text,
                                    widget.categorie,
                                    context,
                                    localAnimationController,
                                  );
                                  widget.itemName.clear();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            color: Colors.black))),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
      },
      child: Text(widget.categorieTitle),
    );
  }
}
