class Ticket {
  DateTime date;
  String receiver;
  int total;
  List<int> image;

  Ticket(this.date, this.total, this.receiver, this.image);

  Map<String, dynamic> toMap() {
    return {'receiver': receiver, 'total': total, 'date': date, 'image': image};
  }
}
