class Ticket {
  int? id;
  String issuer;
  String date;
  int total;
  List<int> photo;
  String categ;

  Ticket(
      {this.id,
      required this.issuer,
      required this.date,
      required this.total,
      required this.photo,
      required this.categ});

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
      id: json['id'],
      issuer: json['issuer'],
      date: json['date'],
      total: json['total'],
      photo: json['photo'],
      categ: json['categ']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issuer': issuer,
      'date': date,
      'total': total,
      'photo': photo,
      'categ': categ
    };
  }
}
