class Inspiration {
  final String text;
  final String author;

  Inspiration({required this.text, required this.author});

  factory Inspiration.fromJson(Map<String, dynamic> json) {
    return Inspiration(
      text: json['text'],
      author: json['author'] ?? 'Unknown',
    );
  }
}
