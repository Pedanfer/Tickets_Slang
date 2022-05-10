class Ticket {
  int? id;
  int? synchronized;
  String ticketName;
  String issuer;
  String date;
  String hour;
  double total;
  List<int> photo;
  String categ1;
  String categ2;

  Ticket(
      {this.id,
      this.synchronized,
      required this.issuer,
      required this.ticketName,
      required this.date,
      required this.hour,
      required this.total,
      required this.photo,
      required this.categ1,
      required this.categ2});

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
      id: json['id'],
      synchronized: json['synchronized'],
      ticketName: json['ticketName'],
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
      ' synchronized': synchronized,
      'ticketName': ticketName,
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
