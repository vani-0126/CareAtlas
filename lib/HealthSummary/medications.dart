import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import "package:health_bridge/HealthSummary/allergies.dart";
import 'models/health_summary.dart';
import 'package:health_bridge/Database/database_helper.dart';

class Medications extends StatefulWidget {
  final HealthSummary healthSummary;
  final bool fromManagmentScreen;

  const Medications({
    super.key,
    required this.healthSummary,
    this.fromManagmentScreen = false,
  });
  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  final TextEditingController medicationNameController =
      TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController medicationNotesController =
      TextEditingController();
  final List<String> frequencyOptions = [
    "Once Daily",
    "Twice Daily",
    "Every Other Day",
    "3 Times Daily",
    "Weekly",
    "As needed",
    "Other",
  ];
  final List<String> medicationStatusType = ["Current", "Past"];
  String? selectedFrequency;
  String? selectedMedicationStatus;
  int? selectedStartYear;
  int? editingIndex2;

  @override
  void dispose() {
    medicationNameController.dispose();
    dosageController.dispose();
    medicationNotesController.dispose();
    super.dispose();
  }

  Future<void> loadMedications() async {
    try {
      final savedMedications = await DatabaseHelper.instance.getSummaryEntries(
        'medications',
      );

      if (!mounted) return;

      setState(() {
        widget.healthSummary.medications
          ..clear()
          ..addAll(savedMedications);
      });
    } catch (e) {
      debugPrint('Error loading medications: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadMedications();
  }

  bool _isAddingMedication = false;

  @override
  Widget build(BuildContext context) {
    return _isAddingMedication
        ? _buildAddMedicationForm()
        : _buildAddMedicationtile();
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

            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  setState(() {
                    editingIndex2 = index;

                    medicationNameController.text = medication['name'] ?? '';
                    dosageController.text = medication['dosage'] ?? '';
                    medicationNotesController.text =
                        medication['mednotes'] ?? '';

                    selectedMedicationStatus = medication['medstatus'];
                    selectedStartYear = medication['startdate'];
                    selectedFrequency = medication['frequency'];

                    _isAddingMedication = true;
                  });
                } else if (value == 'delete') {
                  final medication = widget.healthSummary.medications[index];
                  final id = medication['id'];

                  if (id == null) return;

                  try {
                    await DatabaseHelper.instance.deleteSummaryEntry(
                      'medications',
                      id as int,
                    );

                    if (!mounted) return;

                    setState(() {
                      widget.healthSummary.medications.removeAt(index);
                    });
                  } catch (e) {
                    debugPrint('Error deleting medication: $e');
                  }
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

  Widget _buildAddMedicationtile() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 181, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 181, 247),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Medications",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please enter your medication information below. This will help you keep track of your medications and make it easier for your doctor to understand your health history.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),
            for (int i = 0; i < widget.healthSummary.medications.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: buildMedicationCard(
                  widget.healthSummary.medications[i],
                  i,
                ),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingMedication = true; // Show the input fields
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
                          "Add a Medicaation",
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
                          builder: (context) => Allergies(
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

  Widget _buildAddMedicationForm() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 181, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 181, 247),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Medications",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please enter your medication information below. This will help you keep track of your medications and make it easier for your doctor to understand your health history.",
              textAlign: TextAlign.center,
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
                      controller: medicationNameController,
                      decoration: const InputDecoration(
                        labelText: 'Medication Name',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dosageController,
                      decoration: const InputDecoration(
                        labelText: 'Dosage',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: frequencyOptions.map((status) {
                      return ChoiceChip(
                        label: Text(status),
                        selected:
                            selectedFrequency ==
                            status, // You can manage selection state here
                        onSelected: (selected) {
                          setState(() {
                            selectedFrequency = selected ? status : null;
                          });
                        },
                      );
                    }).toList(),
                  ), //Wrap
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: medicationStatusType.map((status) {
                      return ChoiceChip(
                        label: Text(status),
                        selected:
                            selectedMedicationStatus ==
                            status, // You can manage selection state here
                        onSelected: (selected) {
                          setState(() {
                            selectedMedicationStatus = selected ? status : null;
                          });
                        },
                      );
                    }).toList(),
                  ), //Wrap
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime(
                        selectedStartYear ?? DateTime.now().year,
                      ),
                      minimumYear: 1920,
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: (DateTime newDate) {
                        setState(() {
                          selectedStartYear = newDate.year;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: medicationNotesController,
                      minLines: 4,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        fillColor: Colors.white,
                        filled: true,
                      ), //input decoration
                    ), //Textfield
                  ), //Padding
                  SizedBox(height: 20),
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
                        final medication = <String, dynamic>{
                          'name': medicationNameController.text,
                          'dosage': dosageController.text,
                          'frequency': selectedFrequency,
                          'medstatus': selectedMedicationStatus,
                          'startdate': selectedStartYear,
                          'mednotes': medicationNotesController.text,
                        };

                        try {
                          if (editingIndex2 == null) {
                            final id = await DatabaseHelper.instance
                                .insertSummaryEntry('medications', medication);

                            medication['id'] = id;

                            if (!mounted) return;

                            setState(() {
                              widget.healthSummary.medications.add(medication);
                            });
                          } else {
                            final oldMedication = widget
                                .healthSummary
                                .medications[editingIndex2!];

                            medication['id'] = oldMedication['id'];

                            await DatabaseHelper.instance.updateSummaryEntry(
                              'medications',
                              medication,
                            );

                            if (!mounted) return;

                            setState(() {
                              widget.healthSummary.medications[editingIndex2!] =
                                  medication;
                            });
                          }

                          medicationNameController.clear();
                          dosageController.clear();
                          medicationNotesController.clear();

                          if (!mounted) return;

                          setState(() {
                            editingIndex2 = null;
                            selectedFrequency = null;
                            selectedMedicationStatus = null;
                            selectedStartYear = null;
                            _isAddingMedication = false;
                          });
                        } catch (e) {
                          debugPrint('Error saving medication: $e');
                        }
                      },
                      child: Text(
                        editingIndex2 == null
                            ? 'Save Medication'
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
