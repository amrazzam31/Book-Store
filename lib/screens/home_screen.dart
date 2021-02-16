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
      body: CustomScrollView(slivers: <Widget>[
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
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewBook()),
                  );
                },
              ),
            ]),
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
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
                crossAxisCount: 2),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                Book book = provider.booksList[index];
                return Container(
                  height: 120,
                  child: GestureDetector(
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
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 140,
                              child: Utility.imageFromBase64String(
                                  book.image),
                            ),
                          ),
                          Text(
                            book.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Quantity: ${book.quantity}',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      );
                    }),
                  ),
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
