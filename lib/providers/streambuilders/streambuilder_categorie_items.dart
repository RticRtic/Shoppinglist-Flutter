import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/firebase/firebase.dart';

class CategorieStreamBuilderItems extends StatefulWidget {
  int index;
  String categorieDoc;
  bool showUpdateItemForm = false;
  CategorieStreamBuilderItems(
      {super.key,
      required this.index,
      required this.categorieDoc,
      required this.showUpdateItemForm});

  @override
  State<CategorieStreamBuilderItems> createState() =>
      _CategorieStreamBuilderItemsState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
final firebseProvider = FirebaseProvider();

List<TextEditingController> itemControllerList = [];
late AnimationController localAnimationController;

class _CategorieStreamBuilderItemsState
    extends State<CategorieStreamBuilderItems>
    with SingleTickerProviderStateMixin {
  late Stream<QuerySnapshot> shoppingListStream = db
      .collection("user")
      .doc(widget.categorieDoc)
      .collection("items")
      .snapshots();

  @override
  void initState() {
    super.initState();
    widget.showUpdateItemForm = false;
    localAnimationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 900));
  }

  @override
  void dispose() {
    widget.showUpdateItemForm;
    for (var controller in itemControllerList) {
      controller.dispose();
    }
    itemControllerList.clear();
    localAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: shoppingListStream,
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("X");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }

          return ReorderableListView(
              onReorder: ((oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;

                  final item = snapshot.data!.docs.removeAt(oldIndex);
                  snapshot.data!.docs.insert(newIndex, item);
                });
              }),
              children: [
                for (final itemName in snapshot.data!.docs)
                  widget.showUpdateItemForm
                      ? ListView.builder(
                          key: ValueKey(itemName),
                          shrinkWrap: true,
                          //* set the itemCount to 1 because I already do length-loop ahead
                          itemCount: 1,
                          itemBuilder: ((context, index) {
                            var controller = TextEditingController();
                            itemControllerList.add(controller);
                            return Card(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: controller,
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            if (controller.text == "") {
                                              snackbar.topSnackBarError(
                                                  Overlay.of(context),
                                                  "Please enter new item to update",
                                                  localAnimationController);
                                            } else {
                                              controller.text.isNotEmpty
                                                  ? firebseProvider.upDateItem(
                                                      widget.categorieDoc,
                                                      itemName.get("itemName"),
                                                      controller.text)
                                                  : null;
                                              setState(() {
                                                snackbar.topSnackBarSuccess(
                                                    Overlay.of(context),
                                                    "Successfully updated ${controller.text} in ${widget.categorieDoc}",
                                                    localAnimationController);
                                                widget.showUpdateItemForm =
                                                    false;
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                        ),
                                        hintText: "${itemName.get("itemName")}",
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      : ListTile(
                          key: ValueKey(itemName),
                          leading: Card(
                            child: Container(
                                width: 230,
                                height: 150,
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${itemName.get("itemName")}"),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.showUpdateItemForm = true;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.update,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              firebseProvider.deleteItem(widget.categorieDoc,
                                  "${itemName.get("itemName")}");
                            },
                            child: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ))
              ]);
        }));
  }
}
