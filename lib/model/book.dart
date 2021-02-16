class Book {
  int _id;
  String _name;
  String _description;
  int _quantity;
  String _image;

  Book.newValues(this._id, this._description, this._name, this._quantity, this._image);

  Book(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _description = obj['description'];
    _quantity = obj['quantity'];
    _image = obj['image'];
  }

  Book.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _description = data['description'];
    _quantity = data['quantity'];
    _image = data['image'];
  }

  Map<String, dynamic> toMap() => {
    'id': _id,
    'name': _name,
    'description': _description,
    'quantity': _quantity,
    'image': _image,
  };

  int get id => _id;

  String get name => _name;

  String get description => _description;

  String get image => _image;


  int get quantity => _quantity;
}
