class Inspiration {
  final int? id;
  final String text;
  final String author;
  final String? imageUrl;

  Inspiration({this.id, required this.text, required this.author, this.imageUrl});

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'author': author,
    'imageUrl': imageUrl,
  };

  factory Inspiration.fromJson(Map<String, dynamic> json) {
    return Inspiration(
      id: json['id'],
      text: json['text'],
      author: json['author'],
      imageUrl: json['imageUrl'],
    );
  }
}