import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/firebase/firebase.dart';
import 'package:shoppinglist_provider/models/shopping_item.dart';
import 'package:shoppinglist_provider/utils/snackbar.dart';

class ModalBottomSheet extends StatefulWidget {
  int index;
  String categorieTitle;
  ModalBottomSheet(
      {super.key, required this.index, required this.categorieTitle});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = FirebaseProvider();
    final itemName = TextEditingController();
    final snackbar = SnackbarUtil();
    late AnimationController localAnimationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 900));

    return FloatingActionButton(
      backgroundColor: Colors.grey,
      onPressed: () {
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
                              controller: itemName,
                              autofocus: true,
                              decoration: InputDecoration(
                                  hintText:
                                      "Add to ${widget.categorieTitle}-list",
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (itemName.text.isEmpty) {
                                snackbar.topSnackBarError(
                                    Overlay.of(context),
                                    "Please enter item",
                                    localAnimationController);
                              } else {
                                firebaseProvider.addItem(
                                    ShoppingItem(name: itemName.text),
                                    itemName.text,
                                    widget.categorieTitle,
                                    context,
                                    localAnimationController);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(
                                          color: Colors.black))),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
      },
      child: const Icon(Icons.add),
    );
  }
}
