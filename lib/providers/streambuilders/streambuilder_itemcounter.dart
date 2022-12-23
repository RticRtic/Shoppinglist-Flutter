import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/firebase/firebase.dart';

class TotalItemCounter extends StatefulWidget {
  TotalItemCounter({super.key});

  @override
  State<TotalItemCounter> createState() => _TotalItemCounterState();
}

FirebaseFirestore db = FirebaseFirestore.instance;
final firebseProvider = FirebaseProvider();
final totalDocItemsList = [];
var totalItems = 0;

class _TotalItemCounterState extends State<TotalItemCounter> {
  late Stream<QuerySnapshot> shoppingListStream =
      db.collection("user").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: shoppingListStream,
        builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("X");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            snapshot.data!.docs.forEach(
              (doc) async {
                await db
                    .collection("user")
                    .doc(doc.id)
                    .collection("items")
                    .get()
                    .then((documents) => {
                          setState(() {
                            totalDocItemsList.add(documents.docs.length);
                            totalItems = totalDocItemsList
                                .reduce((value, element) => value + element);
                          })
                        });
              },
            );
            totalDocItemsList.clear();
          }

          return Text("$totalItems");
        }));
  }
}

class ItemCounter with ChangeNotifier {
  int itemCounter = 0;
  int get count => itemCounter;

  void increment(int totalItems) {
    notifyListeners();
  }
}
