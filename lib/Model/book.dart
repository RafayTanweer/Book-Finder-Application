class Book {
  String? bookId;
  String? name;
  String? cover;
  num? rating;
  String? url;

  Book(
      {this.bookId,
      this.name,
      this.cover,
      this.rating,
      this.url});

  Book.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'].toString();
    name = json['name'];
    cover = json['cover'];
    rating = json['rating'];
    url = json['url'];
  }

  Book.fromJsonNominated(Map<String, dynamic> json) {
    bookId = json['book_id'];
    name = json['name'];
    cover = json['cover'];
    rating = json['rating'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['rating'] = this.rating;
    data['url'] = this.url;
    return data;
  }
}