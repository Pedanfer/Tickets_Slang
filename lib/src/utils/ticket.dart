class Ticket {
  int? id;
  String issuer;
  String date;
  String hour;
  int total;
  List<int> photo;
  String categ1;
  String categ2;

  Ticket(
      {this.id,
      required this.issuer,
      required this.date,
      required this.hour,
      required this.total,
      required this.photo,
      required this.categ1,
      required this.categ2});

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
      id: json['id'],
      issuer: json['issuer'],
      date: json['date'],
      hour: json['hour'],
      total: json['total'],
      photo: json['photo'],
      categ1: json['categ1'],
      categ2: json['categ2']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'issuer': issuer,
      'date': date,
      'hour': hour,
      'total': total,
      'photo': photo,
      'categ1': categ1,
      'categ2': categ2
    };
  }
}
