import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/HealthSummary/medical_history.dart';
import 'models/health_summary.dart';
import 'package:health_bridge/Database/database_helper.dart';

class Allergies extends StatefulWidget {
  final HealthSummary healthSummary;
  final bool fromManagmentScreen;

  const Allergies({
    super.key,
    required this.healthSummary,
    this.fromManagmentScreen = false,
  });
  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  final TextEditingController allergyNameController = TextEditingController();
  final TextEditingController allergyReactionController =
      TextEditingController();
  final TextEditingController allegryNotesController = TextEditingController();
  final List<String> severityType = ["Mild", "Moderate", "Severe"];
  String? selectedSeverity; //Variable that holds selected severity
  int? editingIndex3;

  @override
  void dispose() {
    allergyNameController.dispose();
    allergyReactionController.dispose();
    allegryNotesController.dispose();
    super.dispose();
  }

  Future<void> loadAllergies() async {
    final savedAllergies = await DatabaseHelper.instance.getSummaryEntries(
      'allergies',
    );

    if (!mounted) return;

    setState(() {
      widget.healthSummary.allergies
        ..clear()
        ..addAll(savedAllergies);
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllergies();
  }

  bool _isAddingAllergy = false;

  @override
  Widget build(BuildContext context) {
    return _isAddingAllergy ? buildAddAllergyForm() : buildAddAllergyTile();
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

            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  setState(() {
                    editingIndex3 = index;

                    allergyNameController.text = allergy['allergen'] ?? '';
                    allergyReactionController.text = allergy['reaction'] ?? '';
                    allegryNotesController.text = allergy['allergynotes'] ?? '';
                    selectedSeverity = allergy['severity'];

                    _isAddingAllergy = true;
                  });
                } else if (value == 'delete') {
                  final id = allergy['id'];

                  if (id != null) {
                    await DatabaseHelper.instance.deleteSummaryEntry(
                      'allergies',
                      id as int,
                    );
                  }

                  if (!mounted) return;

                  setState(() {
                    widget.healthSummary.allergies.removeAt(index);
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

  Widget buildAddAllergyTile() {
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
              "Allergies",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add your allergies below or skip to the next section!",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),

            for (int i = 0; i < widget.healthSummary.allergies.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: buildAllergyCard(widget.healthSummary.allergies[i], i),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingAllergy = true; // Show the input fields
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
                          "Add an Allergy",
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
                          builder: (context) => MedicalHistory(
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

  Widget buildAddAllergyForm() {
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
              "Allergies",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add your allergies below or skip to the next section!",
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
                      controller: allergyNameController,
                      decoration: const InputDecoration(
                        labelText: 'Allergen',
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: allergyReactionController,
                      decoration: const InputDecoration(
                        labelText: 'Reaction',
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
                    children: severityType.map((status) {
                      return ChoiceChip(
                        label: Text(status),
                        selected:
                            selectedSeverity ==
                            status, // You can manage selection state here
                        onSelected: (selected) {
                          setState(() {
                            selectedSeverity = selected ? status : null;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: allegryNotesController,
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
                        final allergy = <String, dynamic>{
                          'allergen': allergyNameController.text,
                          'reaction': allergyReactionController.text,
                          'severity': selectedSeverity,
                          'allergynotes': allegryNotesController.text,
                        };

                        if (editingIndex3 == null) {
                          // Insert a new allergy into SQLite.
                          final id = await DatabaseHelper.instance
                              .insertSummaryEntry('allergies', allergy);

                          allergy['id'] = id;

                          if (!mounted) return;

                          setState(() {
                            widget.healthSummary.allergies.add(allergy);
                          });
                        } else {
                          // Preserve the existing database ID when editing.
                          final oldAllergy =
                              widget.healthSummary.allergies[editingIndex3!];

                          allergy['id'] = oldAllergy['id'];

                          if (allergy['id'] != null) {
                            await DatabaseHelper.instance.updateSummaryEntry(
                              'allergies',
                              allergy,
                            );
                          } else {
                            // Handles an older in-memory entry that has no database ID.
                            final id = await DatabaseHelper.instance
                                .insertSummaryEntry('allergies', allergy);
                            allergy['id'] = id;
                          }

                          if (!mounted) return;

                          setState(() {
                            widget.healthSummary.allergies[editingIndex3!] =
                                allergy;
                          });
                        }

                        allergyNameController.clear();
                        allergyReactionController.clear();
                        allegryNotesController.clear();

                        setState(() {
                          selectedSeverity = null;
                          editingIndex3 = null;
                          _isAddingAllergy = false;
                        });
                      },
                      child: Text(
                        editingIndex3 == null ? 'Save Allergy' : 'Save Changes',
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
