import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/models/shopping_item.dart';
import 'package:shoppinglist_provider/utils/snackbar.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final snackbar = SnackbarUtil();
late bool exist;

class FirebaseProvider {
  void addItem(ShoppingItem shoppingItem, String doc, String categorie, context,
      AnimationController localAnimationController) async {
    if (await checkIfDocExistGreens(categorie, doc)) {
      snackbar.topSnackBarInfo(
          Overlay.of(context),
          "$doc already exists in $categorie shoppinglist",
          localAnimationController);
    } else {
      await db
          .collection("user")
          .doc(categorie)
          .collection("items")
          .doc(doc)
          .set({"itemName": shoppingItem.name});

      snackbar.topSnackBarSuccess(Overlay.of(context),
          "$doc added to $categorie", localAnimationController);
    }
  }

  void upDateItem(String categorieDoc, String doc, String newValue) async {
    deleteItem(categorieDoc, doc);
    await db
        .collection("user")
        .doc(categorieDoc)
        .collection("items")
        .doc(newValue)
        .set({"itemName": newValue});
  }

  void deleteItem(String categorieDoc, String doc) async {
    await db
        .collection("user")
        .doc(categorieDoc)
        .collection("items")
        .doc(doc)
        .delete()
        .then((document) {}, onError: (e) {
      print("Error deleting document $e");
    });
  }

  Future<bool> checkIfDocExistGreens(String categorieDoc, String doc) async {
    try {
      await db
          .collection("user")
          .doc(categorieDoc)
          .collection("items")
          .doc(doc)
          .get()
          .then((document) {
        exist = document.exists;
      });
      return exist;
    } catch (e) {
      return false;
    }
  }
}
