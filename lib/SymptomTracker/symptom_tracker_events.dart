class SymptomTrackerEvent {
  int? id;
  String? symptomName;
  String? symptomSeverity;
  DateTime? symptomDate;
  String? symptomTime;
  String? symptomDuration;
  String? symptomNotes;

  SymptomTrackerEvent({
    this.id,
    required this.symptomName,
    required this.symptomSeverity,
    required this.symptomDate,
    required this.symptomTime,
    required this.symptomDuration,
    required this.symptomNotes,
  });
}
