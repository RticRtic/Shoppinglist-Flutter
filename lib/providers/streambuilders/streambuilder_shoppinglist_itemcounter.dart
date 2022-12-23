import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/firebase/firebase.dart';

class ShoppingListStreamBuilderItemCounter extends StatefulWidget {
  int index;
  String categorieDoc;
  ShoppingListStreamBuilderItemCounter(
      {super.key, required this.index, required this.categorieDoc});

  @override
  State<ShoppingListStreamBuilderItemCounter> createState() =>
      _ShoppingListStreamBuilderItemCounterState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
final firebseProvider = FirebaseProvider();

class _ShoppingListStreamBuilderItemCounterState
    extends State<ShoppingListStreamBuilderItemCounter> {
  late Stream<QuerySnapshot> shoppingListStream = db
      .collection("user")
      .doc(widget.categorieDoc)
      .collection("items")
      .snapshots();

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

          return Text("${snapshot.data!.docs.length}");
        }));
  }
}
