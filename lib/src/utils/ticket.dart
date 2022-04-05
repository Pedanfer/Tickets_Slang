class Ticket {
  int? id;
  String issuer;
  String date;
  String hour;
  int total;
  List<int> photo;
  String categ;

  Ticket(
      {this.id,
      required this.issuer,
      required this.date,
      required this.hour,
      required this.total,
      required this.photo,
      required this.categ});

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
      id: json['id'],
      issuer: json['issuer'],
      date: json['date'],
      hour: json['hour'],
      total: json['total'],
      photo: json['photo'],
      categ: json['categ']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issuer': issuer,
      'date': date,
      'hour': hour,
      'total': total,
      'photo': photo,
      'categ': categ
    };
  }
}
