import 'package:book_store/provider/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_store/model/book.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:book_store/utility.dart';

class BookDetails extends StatefulWidget {
  final int id;

  BookDetails(this.id);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    Provider.of<BookProvider>(context, listen: false).getBook(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Book book = Provider
        .of<BookProvider>(context)
        .book;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Material(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: book == null
                ? CircularProgressIndicator()
                : Column(
              children: <Widget> [
                Expanded(
                  child: Container(
                    width: 220,
                    height: 140,
                    child: Utility.imageFromBase64String(
                        book.image),),
                ),
                SizedBox(height: 15,),
                Text(book.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10.0,
                ),
                Text(book.description, style: TextStyle(color: Colors.grey[600], fontSize: 18),),
                SizedBox(height: 10,),
                Text(
                  'Quantity: ${book.quantity}',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  elevation: 5,
                  color: Colors.grey,
                  padding: EdgeInsets.fromLTRB(130, 18, 130, 18),
                  onPressed: () {
                    if (book.quantity != 0) {
                      Alert(
                          context: context,
                          type: AlertType.none,
                          title: "Do you want to borrow this book?",
                          buttons: [
                            DialogButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.deepOrange,
                            ),
                            DialogButton(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () {
                                Provider.of<BookProvider>(context, listen: false)
                                    .updateBook(
                                  book.id,
                                  Book.newValues(
                                    book.id,
                                    book.description,
                                    book.name,
                                    book.quantity - 1,
                                    book.image,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              color: Colors.deepOrange,
                            ),
                          ]).show();
                    }
                  },
                  child: Text(
                    'Borrow',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
