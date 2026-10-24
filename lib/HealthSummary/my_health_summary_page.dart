import 'package:flutter/material.dart';
import 'package:health_bridge/Dashboards/prepare_dashboard.dart';
import 'package:health_bridge/HealthSummary/empty_health_summary.dart';
import 'package:health_bridge/HealthSummary/managment_screen.dart';
import 'models/health_summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/Database/database_helper.dart';

class MyHealthSummary extends StatefulWidget {
  final HealthSummary healthSummary;

  const MyHealthSummary({super.key, required this.healthSummary});

  @override
  State<MyHealthSummary> createState() => MyHealthSummaryState();
}

class MyHealthSummaryState extends State<MyHealthSummary> {
  @override
  bool _isLoadingSummary = true;

  Future<void> loadHealthSummary() async {
    final db = DatabaseHelper.instance;

    final conditions = await db.getSummaryEntries('conditions');
    final medications = await db.getSummaryEntries('medications');
    final allergies = await db.getSummaryEntries('allergies');
    final histories = await db.getSummaryEntries('medical_histories');
    final notes = await db.getSummaryEntries('health_notes');

    if (!mounted) return;

    setState(() {
      widget.healthSummary.conditions
        ..clear()
        ..addAll(conditions);

      widget.healthSummary.medications
        ..clear()
        ..addAll(medications);

      widget.healthSummary.allergies
        ..clear()
        ..addAll(allergies);

      widget.healthSummary.histories
        ..clear()
        ..addAll(histories);

      widget.healthSummary.notes
        ..clear()
        ..addAll(notes);

      _isLoadingSummary = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadHealthSummary();
  }

  @override
  Widget build(BuildContext context) {
    bool hasHealthSummary =
        widget.healthSummary.conditions.isNotEmpty ||
        widget.healthSummary.medications.isNotEmpty ||
        widget.healthSummary.allergies.isNotEmpty ||
        widget.healthSummary.histories.isNotEmpty ||
        widget.healthSummary.notes.isNotEmpty;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 181, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 181, 247),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PrepareDashboard(healthSummary: widget.healthSummary),
              ),
              (route) => route.isFirst,
            );
          },
        ),
      ),
      body: _isLoadingSummary
          ? const Center(child: CircularProgressIndicator())
          : hasHealthSummary
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "My Health Summary",
                    style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 72, 26, 102),
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    color: const Color.fromARGB(255, 237, 181, 247),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(35),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManagmentScreen(
                              healthSummary: widget.healthSummary,
                            ),
                          ),
                        );

                        // Refresh the summary after returning from management.
                        await loadHealthSummary();
                      },
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.manage_accounts,
                              size: 35,
                              color: Colors.purple,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "add, edit, or delete information",
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
                  const SizedBox(height: 20),
                  Text(
                    "Medical Conditions",
                    style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  for (
                    int i = 0;
                    i < widget.healthSummary.conditions.length;
                    i++
                  )
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildConditionCard(
                        widget.healthSummary.conditions[i],
                        i,
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    "Medications",
                    style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  for (
                    int i = 0;
                    i < widget.healthSummary.medications.length;
                    i++
                  )
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildMedicationCard(
                        widget.healthSummary.medications[i],
                        i,
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    "Allergies",
                    style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  for (
                    int i = 0;
                    i < widget.healthSummary.allergies.length;
                    i++
                  )
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildAllergyCard(
                        widget.healthSummary.allergies[i],
                        i,
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    "Medical History",
                    style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  for (
                    int i = 0;
                    i < widget.healthSummary.histories.length;
                    i++
                  )
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildHistoryCard(
                        widget.healthSummary.histories[i],
                        i,
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    "Health Notes",
                    style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  for (int i = 0; i < widget.healthSummary.notes.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: buildNoteCard(widget.healthSummary.notes[i], i),
                    ),
                ],
              ),
            )
          : EmptyHealthSummary(healthSummary: widget.healthSummary),
    );
  }

  Widget buildConditionCard(Map<String, dynamic> condition, int index) {
    return Card(
      color: const Color.fromARGB(255, 246, 208, 253),
      elevation: 10,
      child: ListTile(
        title: Text(condition['name'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${condition['status'] ?? ''}'),
            Text('Year: ${condition['year'] ?? ''}'),
            Text('Notes: ${condition['notes'] ?? ''}'),
          ],
        ),
      ),
    );
  }

  Widget buildMedicationCard(Map<String, dynamic> medication, int index) {
    return Card(
      color: const Color.fromARGB(255, 246, 208, 253),
      elevation: 10,
      child: ListTile(
        title: Text(medication['name'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dosage: ${medication['dosage'] ?? ''}'),
            Text('Frequency: ${medication['frequency'] ?? ''}'),
            Text('Status: ${medication['medstatus'] ?? ''}'),
            Text('Year: ${medication['startdate'] ?? ''}'),
            Text('Notes: ${medication['mednotes'] ?? ''}'),
          ],
        ),
      ),
    );
  }

  Widget buildAllergyCard(Map<String, dynamic> allergy, int index) {
    return Card(
      color: const Color.fromARGB(255, 246, 208, 253),
      elevation: 10,
      child: ListTile(
        title: Text(allergy['allergen'] ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reaction: ${allergy['reaction'] ?? ''}'),
            Text('Severity: ${allergy['severity'] ?? ''}'),
            Text('Notes: ${allergy['allergynotes'] ?? ''}'),
          ],
        ),
      ),
    );
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
          ],
        ),
      ),
    );
  }

  Widget buildNoteCard(Map<String, dynamic> note, int index) {
    return Card(
      color: const Color.fromARGB(255, 246, 208, 253),
      elevation: 10,
      child: ListTile(
        subtitle: Column(
          children: [Text('Health Note: ${note['notes'] ?? ''}')],
        ),
      ),
    );
  }
}
