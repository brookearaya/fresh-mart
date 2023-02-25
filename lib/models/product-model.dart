class Products {
  String id;
  String Title;
  String ImageUrl;
  num Price;
  String Category;
  int Quantity;
  int count;
  Products(
      {required this.Title,
      required this.ImageUrl,
      required this.Price,
      required this.Category,
      required this.id,
        required this.count,
      required this.Quantity});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "Title": this.Title,
      "ImageUrl": this.ImageUrl,
      "Price": this.Price,
      "Category": this.Category,
      "Quantity": this.Quantity,
      "count": this.count,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'Title': this.Title,
      'ImageUrl': this.ImageUrl,
      'Price': this.Price,
      'Category': this.Category,
      'Quantity': this.Quantity,
      'count': this.count,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] as String,
      Title: map['Title'] as String,
      ImageUrl: map['ImageUrl'] as String,
      Price: map['Price'] as num,
      Category: map['Category'] as String,
      Quantity: map['Quantity'] as int,
      count: map['count'] as int,
    );
  }
//

//

//

}
