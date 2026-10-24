import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/SymptomTracker/symptom_tracker_events.dart';
import 'package:health_bridge/Dashboards/track_dashboard.dart';
import 'package:health_bridge/SymptomTracker/symptom_history.dart';
import 'package:health_bridge/Database/database_helper.dart';

class SymptomTrackerMain extends StatefulWidget {
  const SymptomTrackerMain({super.key});
  @override
  State<SymptomTrackerMain> createState() => _SymptomTrackerMainState();
}

class _SymptomTrackerMainState extends State<SymptomTrackerMain> {
  List<SymptomTrackerEvent> symptoms = [];
  bool _isAddingSymptom = false;
  final TextEditingController _symptomNameController = TextEditingController();
  final TextEditingController _symptomDurationController =
      TextEditingController();
  final TextEditingController _symptomNotesController = TextEditingController();
  final now = DateTime.now();
  String? selectedSeverity;
  DateTime? selectedSymptomDate;
  TimeOfDay? selectedSymptomTime;
  final List<String> severityOptions = ['Mild', 'Moderate', 'Severe'];
  SymptomTrackerEvent? _editingSymptom;

  int get uniqueSymptomsToday {
    final currentDate = DateTime.now();
    final Set<String> uniqueNames = {};
    for (final symptom in symptoms) {
      final date = symptom.symptomDate;
      final name = symptom.symptomName;
      if (date == null || name == null || name.isEmpty) {
        continue;
      }
      if (date.year == currentDate.year &&
          date.month == currentDate.month &&
          date.day == currentDate.day) {
        uniqueNames.add(name.toLowerCase());
      }
    }
    return uniqueNames.length;
  }

  int get entriesToday {
    final currentDate = DateTime.now();
    int count = 0;
    for (final symptom in symptoms) {
      final date = symptom.symptomDate;
      if (date == null) {
        continue;
      }
      if (date.year == currentDate.year &&
          date.month == currentDate.month &&
          date.day == currentDate.day) {
        count++;
      }
    }
    return count;
  }

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedSymptomDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedSymptomTime = pickedTime;
      });
    }
  }

  void editSymptom(SymptomTrackerEvent event) {
    setState(() {
      _editingSymptom = event;

      _symptomNameController.text = event.symptomName ?? "";
      _symptomDurationController.text = event.symptomDuration ?? "";
      _symptomNotesController.text = event.symptomNotes ?? "";

      selectedSeverity = event.symptomSeverity;
      selectedSymptomDate = event.symptomDate;

      _isAddingSymptom = true;
    });
  }

  Future<void> loadSymptoms() async {
    final savedSymptoms = await DatabaseHelper.instance.getSymptoms();

    if (!mounted) return;

    setState(() {
      symptoms = savedSymptoms;
    });
  }

  void initState() {
    super.initState();
    loadSymptoms();
  }

  List<SymptomTrackerEvent> get recentSymptoms {
    List<SymptomTrackerEvent> sortedSymptoms = symptoms.where((symptom) {
      return symptom.symptomDate != null;
    }).toList();

    sortedSymptoms.sort((a, b) => b.symptomDate!.compareTo(a.symptomDate!));

    return sortedSymptoms.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return _isAddingSymptom
        ? _buildSymptomTrackerForm()
        : _buildSymptomTrackerMain();
  }

  Widget _buildSymptomTrackerMain() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 241, 207),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 241, 207),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TrackDashboard()),
              (route) => route.isFirst,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 35,
                  color: const Color.fromARGB(176, 4, 144, 51),
                ),
                const SizedBox(width: 15),
                Text(
                  "My Symptom Tracker",
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(176, 4, 144, 51),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Record and monitor how you feel over time. Track your symptoms, their severity, and any notes you want to remember.",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(176, 4, 144, 51),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 400,
              height: 175,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(176, 4, 144, 51),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Overview",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unique Symptoms",
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(176, 4, 144, 51),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                uniqueSymptomsToday.toString(),
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(176, 4, 144, 51),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Entries Today",
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(176, 4, 144, 51),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                entriesToday.toString(),
                                style: GoogleFonts.inter(
                                  color: const Color.fromARGB(176, 4, 144, 51),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingSymptom = true; // Show the input fields
                  });
                },
                borderRadius: BorderRadius.circular(35),
                splashColor: Colors.white.withValues(),
                highlightColor: Colors.white.withValues(),
                child: Card(
                  color: const Color.fromARGB(176, 4, 144, 51),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 35, color: Colors.white),
                        SizedBox(width: 15),
                        Text(
                          "Add a Symptom",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Recent Symptoms",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(176, 4, 144, 51),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            buildFirstFiveCards(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(176, 4, 144, 51),
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
                textStyle: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SymptomHistoryPage(symptoms: symptoms),
                  ),
                );
                setState(() {});
              },
              child: Text("View Symptom History"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomTrackerForm() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 241, 207),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 241, 207),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TrackDashboard()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 35,
                  color: const Color.fromARGB(176, 4, 144, 51),
                ),
                const SizedBox(width: 15),
                Text(
                  "My Symptom Tracker",
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(176, 4, 144, 51),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Record and monitor how you feel over time. Track your symptoms, their severity, and any notes you want to remember.",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(176, 4, 144, 51),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Card(
              color: const Color.fromARGB(176, 4, 144, 51),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _symptomNameController,
                      decoration: InputDecoration(
                        labelText: 'Symptom Name',
                        labelStyle: GoogleFonts.inter(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: severityOptions.map((status) {
                      return ChoiceChip(
                        label: Text(status),
                        selected:
                            selectedSeverity ==
                            status, // You can manage selection state here
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedSeverity = status;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Date",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  OutlinedButton(
                    onPressed: pickDate,
                    child: Text(
                      selectedSymptomDate == null
                          ? "Select Date"
                          : "${selectedSymptomDate!.month}/${selectedSymptomDate!.day}/${selectedSymptomDate!.year}",
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Time",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  OutlinedButton(
                    onPressed: pickTime,
                    child: Text(
                      selectedSymptomTime == null
                          ? "Select Time"
                          : selectedSymptomTime!.format(context),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _symptomDurationController,
                      decoration: InputDecoration(
                        labelText: "Duration",
                        labelStyle: GoogleFonts.inter(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _symptomNotesController,
                      decoration: InputDecoration(
                        labelText: "Notes",
                        labelStyle: GoogleFonts.inter(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 33, 83, 40),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                        textStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      onPressed: () async {
                        if (_symptomNameController.text.isEmpty ||
                            selectedSymptomDate == null) {
                          return;
                        }

                        try {
                          if (_editingSymptom != null) {
                            final event = _editingSymptom!;

                            event.symptomName = _symptomNameController.text;
                            event.symptomNotes = _symptomNotesController.text;
                            event.symptomDuration =
                                _symptomDurationController.text;
                            event.symptomDate = selectedSymptomDate!;
                            event.symptomTime = selectedSymptomTime?.format(
                              context,
                            );
                            event.symptomSeverity = selectedSeverity;

                            await DatabaseHelper.instance.updateSymptom(event);

                            if (!mounted) return;

                            setState(() {
                              _editingSymptom = null;
                            });
                          } else {
                            final newSymptom = SymptomTrackerEvent(
                              symptomName: _symptomNameController.text,
                              symptomNotes: _symptomNotesController.text,
                              symptomDate: selectedSymptomDate!,
                              symptomTime: selectedSymptomTime?.format(context),
                              symptomDuration: _symptomDurationController.text,
                              symptomSeverity: selectedSeverity,
                            );

                            final id = await DatabaseHelper.instance
                                .insertSymptom(newSymptom);

                            newSymptom.id = id;

                            if (!mounted) return;

                            setState(() {
                              symptoms.add(newSymptom);
                            });
                          }

                          if (!mounted) return;

                          setState(() {
                            _symptomNameController.clear();
                            _symptomNotesController.clear();
                            _symptomDurationController.clear();

                            selectedSymptomDate = null;
                            selectedSymptomTime = null;
                            selectedSeverity = null;

                            _editingSymptom = null;
                            _isAddingSymptom = false;
                          });
                        } catch (e) {
                          debugPrint('Error saving symptom: $e');
                        }
                      },

                      child: Text(
                        _editingSymptom != null ? "Save Changes" : "Save",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSymptomCards(SymptomTrackerEvent event) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.symptomName ?? "Unknown symptom",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(event.symptomSeverity ?? "No severity provided"),

              Text(
                "${event.symptomDate!.month}/${event.symptomDate!.day}/${event.symptomDate!.year}",
              ),
              if (event.symptomDuration != null)
                Text("Duration: ${event.symptomDuration!}"),

              if (event.symptomTime != null) Text(event.symptomTime!),

              if (event.symptomNotes != null) Text(event.symptomNotes!),

              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'edit') {
                    editSymptom(event);
                  } else if (value == 'delete') {
                    if (event.id == null) return;

                    await DatabaseHelper.instance.deleteSymptom(event.id!);

                    if (!mounted) return;

                    setState(() {
                      symptoms.removeWhere((item) => item.id == event.id);
                    });
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstFiveCards() {
    return Column(
      children: [
        ...recentSymptoms.map((symptom) => buildSymptomCards(symptom)),
      ],
    );
  }
}
