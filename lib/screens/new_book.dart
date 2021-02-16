import 'dart:typed_data';

import 'package:book_store/dbhelper.dart';
import 'package:book_store/model/book.dart';
import 'package:book_store/provider/book_provider.dart';
import 'package:book_store/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewBook extends StatefulWidget {

  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  String name, description;
  int quantity;
  DbHelper helper;
  PickedFile imageFile;
  Future<void> _addImage() async {
    print("sdasda");
    final picker = ImagePicker();
    imageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Book',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Book Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              imageFile == null
                  ? FlatButton.icon(
                icon: Icon(Icons.account_circle),
                textColor: Colors.blue[600],
                label: Text('Add Image'),
                onPressed: _addImage,
              )
                  : Text(
                'Image uploaded',
                style: TextStyle(color: Colors.blue[600]),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    quantity = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: 35,
              ),
              RaisedButton(
                elevation: 5,
                color: Colors.grey,
                padding: EdgeInsets.fromLTRB(140, 20, 140, 20),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  if (name == null || description == null ||  quantity == null || imageFile == null)
                    return;
                  Uint8List image = await imageFile.readAsBytes();
                  String imgString =  Utility.base64String(image);
                  var book = Book({
                    'name': name,
                    'description': description,
                    'quantity': quantity,
                    'image': imgString
                  });
                  Provider.of<BookProvider>(context,listen: false).createBook(book);
                  Navigator.pop(context);
//                  print('pressed $id');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
