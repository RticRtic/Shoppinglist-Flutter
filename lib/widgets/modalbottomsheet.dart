import 'package:flutter/material.dart';
import 'package:shoppinglist_provider/firebase/firebase.dart';
import 'package:shoppinglist_provider/utils/snackbar.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = FirebaseProvider();
    final itemName = TextEditingController();
    final snackbar = SnackbarUtil();
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
                              decoration: const InputDecoration(
                                  hintText: 'Add To Shoppingcart',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (itemName.text.isEmpty) {
                                snackbar.snackbar(context, "Please Enter Text");
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
