class TreatmentEvent {
  int? id;
  String title;
  String type;
  DateTime date;
  String? time;
  String? notes;

  TreatmentEvent({
    this.id,
    required this.title,
    required this.type,
    required this.date,
    this.time,
    this.notes,
  });
}
