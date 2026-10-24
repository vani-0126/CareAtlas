import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_bridge/HealthSummary/health_notes.dart';
import 'models/health_summary.dart';
import 'package:health_bridge/Database/database_helper.dart';

class MedicalHistory extends StatefulWidget {
  final HealthSummary healthSummary;
  final bool fromManagmentScreen;

  const MedicalHistory({
    super.key,
    required this.healthSummary,
    this.fromManagmentScreen = false,
  });
  @override
  State<MedicalHistory> createState() => MedicalHistoryState();
}

class MedicalHistoryState extends State<MedicalHistory> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventReasonController = TextEditingController();
  final TextEditingController eventNotesController = TextEditingController();
  int? selectedYear;
  int? editingIndex4;

  @override
  void dispose() {
    super.dispose();
    eventNameController.dispose();
    eventNotesController.dispose();
    eventReasonController.dispose();
  }

  Future<void> loadMedicalHistory() async {
    final savedHistory = await DatabaseHelper.instance.getSummaryEntries(
      'medical_histories',
    );

    if (!mounted) return;

    setState(() {
      widget.healthSummary.histories
        ..clear()
        ..addAll(savedHistory);
    });
  }

  @override
  void initState() {
    super.initState();
    loadMedicalHistory();
  }

  bool _isAddingMedicalHistory = false;
  @override
  Widget build(BuildContext context) {
    return _isAddingMedicalHistory
        ? buildAddHistoryForm()
        : buildAddHistoryTile();
  }

  Widget buildHistoryCard(Map<String, dynamic> history, int index) {
    return Card(
      color: const Color.fromARGB(255, 246, 208, 253),
      elevation: 10,
      child: ListTile(
        title: Text(history['name'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Year: ${history['year'] ?? ''}'),
            Text('Reason: ${history['reason'] ?? ''}'),
            Text('Notes: ${history['notes'] ?? ''}'),

            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  setState(() {
                    editingIndex4 = index;

                    eventNameController.text = history['name'] ?? '';
                    eventReasonController.text = history['reason'] ?? '';
                    eventNotesController.text = history['notes'] ?? '';
                    selectedYear = history['year'];

                    _isAddingMedicalHistory = true;
                  });
                } else if (value == 'delete') {
                  final id = history['id'];

                  if (id != null) {
                    await DatabaseHelper.instance.deleteSummaryEntry(
                      'medical_histories',
                      id as int,
                    );
                  }

                  if (!mounted) return;

                  setState(() {
                    widget.healthSummary.histories.removeAt(index);
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
    );
  }

  Widget buildAddHistoryTile() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 181, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 181, 247),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Medical History",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add past surgeries, hospitalizations, procedures, or other major medical events or skip to the next section.",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),

            for (int i = 0; i < widget.healthSummary.histories.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: buildHistoryCard(widget.healthSummary.histories[i], i),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingMedicalHistory = true; // Show the input fields
                  });
                },
                borderRadius: BorderRadius.circular(35),
                splashColor: Colors.white.withValues(),
                highlightColor: Colors.white.withValues(),
                child: Card(
                  color: const Color.fromARGB(255, 237, 181, 247),
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
                        Icon(Icons.add, size: 35, color: Colors.purple),
                        SizedBox(width: 15),
                        Text(
                          "Add Medical History",
                          style: GoogleFonts.inter(
                            color: Colors.purple,
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 237, 181, 247),
                    foregroundColor: Colors.black,
                    minimumSize: const Size(100, 40),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (widget.fromManagmentScreen) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthNotes(
                            healthSummary: widget.healthSummary,
                            fromManagmentScreen: widget.fromManagmentScreen,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(widget.fromManagmentScreen ? "Done" : "Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddHistoryForm() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 181, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 181, 247),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Medical History",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add past surgeries, hospitalizations, procedures, or other major medical events or skip to the next section.",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),
            Card(
              color: const Color.fromARGB(255, 246, 208, 253),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: eventNameController,
                      decoration: const InputDecoration(
                        labelText: 'Event/Procedure Name',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(
                        selectedYear ?? DateTime.now().year,
                      ),
                      minimumYear: 1920,
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          selectedYear = newDate.year;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: eventReasonController,
                      minLines: 4,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        labelText: 'Reason',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: eventNotesController,
                      minLines: 4,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          102,
                          40,
                          143,
                        ),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                        textStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () async {
                        final history = <String, dynamic>{
                          'name': eventNameController.text,
                          'year': selectedYear,
                          'reason': eventReasonController.text,
                          'notes': eventNotesController.text,
                        };

                        if (editingIndex4 == null) {
                          // Save a new medical history entry.
                          final id = await DatabaseHelper.instance
                              .insertSummaryEntry('medical_histories', history);

                          history['id'] = id;

                          if (!mounted) return;

                          setState(() {
                            widget.healthSummary.histories.add(history);
                          });
                        } else {
                          // Update the existing entry.
                          final oldHistory =
                              widget.healthSummary.histories[editingIndex4!];

                          history['id'] = oldHistory['id'];

                          if (history['id'] != null) {
                            await DatabaseHelper.instance.updateSummaryEntry(
                              'medical_histories',
                              history,
                            );
                          } else {
                            // Save older entries that do not have a database ID.
                            final id = await DatabaseHelper.instance
                                .insertSummaryEntry(
                                  'medical_histories',
                                  history,
                                );

                            history['id'] = id;
                          }

                          if (!mounted) return;

                          setState(() {
                            widget.healthSummary.histories[editingIndex4!] =
                                history;
                          });
                        }

                        eventNameController.clear();
                        eventReasonController.clear();
                        eventNotesController.clear();

                        setState(() {
                          selectedYear = null;
                          editingIndex4 = null;
                          _isAddingMedicalHistory = false;
                        });
                      },
                      child: Text(
                        editingIndex4 == null
                            ? 'Save Medical Event'
                            : 'Save Changes',
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
}
