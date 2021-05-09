import 'package:book_store/provider/book_provider.dart';
import 'package:book_store/screens/book_details.dart';
import 'package:book_store/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'new_book.dart';
import 'package:book_store/dbhelper.dart';
import 'package:book_store/model/book.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbHelper helper;

  @override
  void initState() {
    super.initState();
    Provider.of<BookProvider>(context, listen: false).fetchAllBook();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewBook();
          }));
        },
      ),
      body: provider.booksList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : provider.booksList.isEmpty
              ? Center(
                  child: Container(
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ))
              : CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 150.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'Book Store',
                        style: TextStyle(fontSize: 25),
                      ),
                      background: Image.asset('images/background.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                        color: Colors.deepOrangeAccent,
                        height: 60,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Text(
                            'New Arrivals'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(15),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 6 / 10,
                          crossAxisCount: 2),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          Book book = provider.booksList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return BookDetails(book.id);
                                }),
                              );
                            },
                            child: Builder(builder: (context) {
                              return Column(
                                children: [
                                  Container(
                                    height: 160,
                                    width: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Utility.imageFromBase64String(
                                          book.image),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    height: 80,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Text(
                                            book.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            'Quantity: ${book.quantity}',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                        childCount: provider.booksList.length,
                      ),
                    ),
                  )
                ]),
    );
  }
}
