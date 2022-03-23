import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/cart_item.dart';
import 'package:firebase/models/product.dart';
import 'package:firebase/product_card.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];

  bool isLoading = false;
  bool canLoadMore=true;

  DocumentSnapshot? lastDocument;

  final ScrollController controller = ScrollController();

  Future<void> loadProducts() async {
    final database = Database();
    setState(() {
      isLoading = true;
    });


    QuerySnapshot collection=await database.getCollection("products", 15);

    if(collection.docs.length<10){
      canLoadMore=false;
    }


      if(collection.docs.isNotEmpty){
        lastDocument=collection.docs.last;
      }


      products = collection
          .docs
          .map((e) => Product(id: e.id, title: (e.data() as Map)['title']))
          .toList();




    setState(() {
      isLoading = false;
    });
  }


  Future<void> loadMore()async{
    if(canLoadMore){
      final database = Database();

      late QuerySnapshot collection;

     try{
       collection= await database.getCollection("products", 15,lastDocument);
     }catch(e){
       collection= await database.getCollection("products",);
     }
      print(collection.docs.length);


      if(collection.docs.length<10){
        canLoadMore=false;
      }

        if(collection.docs.isNotEmpty){
          lastDocument=collection.docs.last;
        }


        products.addAll(collection
            .docs
            .map((e) => Product(id: e.id, title: (e.data() as Map)['title']))
            .toList());

        setState(() {

        });

    }


  }





  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final database = Database();
    final auth = Auth();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                final auth = Auth();

                auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: database.getStreamCollection("users/${auth.uid}/cart"),
              builder: (context, snapshot) {
                List<CartItem> cartItems = List.from(snapshot.data?.docs ?? [])
                    .map((doc) => CartItem(id: doc.id))
                    .toList();

                return NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      if(notification is ScrollEndNotification){
                        if (controller.position.extentAfter == 0) {
                          loadMore();

                        }
                      }
                      return false;
                    },
                    child: ListView.builder(
                      controller: controller,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      itemBuilder: (context, position) {
                        bool isAdded = cartItems
                            .where((carItem) =>
                                carItem.id == products[position].id)
                            .isNotEmpty;

                        return ListTile(
                          title: Text(
                            products[position].title,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isAdded
                                  ? Icons.shopping_cart
                                  : Icons.shopping_cart_outlined,
                              color: isAdded ? Colors.blue : Colors.grey,
                            ),
                            onPressed: () {
                              if (isAdded) {
                                database.deleteDocument(
                                    "users/${auth.uid}/cart/${products[position].id}");
                              } else {
                                database.createDocument(
                                    "users/${auth.uid}/cart/${products[position].id}",
                                    {"quantity": 2});
                              }
                            },
                          ),
                        );
                      },
                      itemCount: products.length,
                    ));
              }),
    );
  }
}
