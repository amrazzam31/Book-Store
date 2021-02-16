import 'package:book_store/dbhelper.dart';
import 'package:book_store/model/book.dart';
import 'package:flutter/cupertino.dart';

class BookProvider extends ChangeNotifier {
  DbHelper _dbHelper = DbHelper();
  List<Book> _booksList;
  Book _book;
  get booksList => _booksList;
  get book => _book;

  fetchAllBook() async {
    final booksListMap = await _dbHelper.allBooks();
    print("object $booksListMap");
    if (booksListMap.isEmpty) {
      _booksList = [];
    } else {
      _booksList = [];
      booksListMap.forEach((element) {
        final book = Book.fromMap(element);
        _booksList.add(book);
      });
    }
    print("object $_booksList");
    notifyListeners();
  }

  getBook(int id) async {
    final book = await _dbHelper.getBook(id);
    print("object $book");
    _book =  Book.fromMap(book);
    print("object $_book");

    notifyListeners();
  }


  createBook(Book book) {
    _dbHelper.createBook(book).then((value) {
      fetchAllBook();
    });
    notifyListeners();
  }


  deleteBook(int id) {
    _dbHelper.deleteBook(id).then((value) {
      fetchAllBook();
    });
    notifyListeners();
  }

  updateBook(int id, Book book) {
    _dbHelper.updateBook(id, book).then((value) {
      getBook(id);
      fetchAllBook();
    });
    notifyListeners();
  }
}
