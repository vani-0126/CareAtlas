import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_bridge/HealthSummary/medications.dart';
import 'models/health_summary.dart';
import 'package:health_bridge/Database/database_helper.dart';

class MedicalConditions extends StatefulWidget {
  final HealthSummary healthSummary;
  final bool fromManagmentScreen;

  const MedicalConditions({
    super.key,
    required this.healthSummary,
    this.fromManagmentScreen = false,
  });
  @override
  State<MedicalConditions> createState() => MedicalConditionsState();
}

class MedicalConditionsState extends State<MedicalConditions> {
  final TextEditingController conditionnameController = TextEditingController();
  final TextEditingController conditionnotesController =
      TextEditingController();
  final List<String> statustype = ["Current", "Past", "Ongoing"];
  String? selectedStatus; // Variable to hold the selected status
  int? selectedYear;
  int? editingIndex; // Variable to hold the index of the condition being edited

  @override
  void dispose() {
    conditionnameController.dispose();
    conditionnotesController.dispose();
    super.dispose();
  }

  Future<void> loadConditions() async {
    try {
      final savedConditions = await DatabaseHelper.instance.getSummaryEntries(
        'conditions',
      );

      if (!mounted) return;

      setState(() {
        widget.healthSummary.conditions
          ..clear()
          ..addAll(savedConditions);
      });
    } catch (e) {
      debugPrint('Error loading conditions: $e');
    }
  }

  bool _isAddingCondition =
      false; // Flag to track if the user is adding a condition
  @override
  void initState() {
    super.initState();
    loadConditions();
  }

  @override
  Widget build(BuildContext context) {
    return _isAddingCondition
        ? _buildAddConditionForm()
        : _buildAddConditionTile();
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

            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  setState(() {
                    editingIndex = index;

                    conditionnameController.text = condition['name'] ?? '';

                    conditionnotesController.text = condition['notes'] ?? '';

                    selectedStatus = condition['status'];
                    selectedYear = condition['year'];

                    _isAddingCondition = true;
                  });
                } else if (value == 'delete') {
                  final condition = widget.healthSummary.conditions[index];
                  final id = condition['id'];

                  if (id == null) return;

                  try {
                    await DatabaseHelper.instance.deleteSummaryEntry(
                      'conditions',
                      id as int,
                    );

                    if (!mounted) return;

                    setState(() {
                      widget.healthSummary.conditions.removeAt(index);
                    });
                  } catch (e) {
                    debugPrint('Error deleting condition: $e');
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

  Widget _buildAddConditionTile() {
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
              "Medical Conditions",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add your medical conditions below or skip to the next section.",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),

            for (int i = 0; i < widget.healthSummary.conditions.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: buildConditionCard(
                  widget.healthSummary.conditions[i],
                  i,
                ),
              ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingCondition = true; // Show the input fields
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
                          "Add a Medical Condition",
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
                          builder: (context) => Medications(
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

  Widget _buildAddConditionForm() {
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
              "Medical Conditions",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add your medical conditions below or skip to the next section.",
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
                      controller: conditionnameController,
                      decoration: const InputDecoration(
                        labelText: 'Condition Name',
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
                    children: statustype.map((status) {
                      return ChoiceChip(
                        label: Text(status),
                        selected:
                            selectedStatus ==
                            status, // You can manage selection state here
                        onSelected: (selected) {
                          setState(() {
                            selectedStatus = selected ? status : null;
                          });
                        },
                      );
                    }).toList(),
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
                      controller: conditionnotesController,
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
                        final condition = <String, dynamic>{
                          'name': conditionnameController.text,
                          'status': selectedStatus,
                          'year': selectedYear,
                          'notes': conditionnotesController.text,
                        };

                        try {
                          if (editingIndex == null) {
                            final id = await DatabaseHelper.instance
                                .insertSummaryEntry('conditions', condition);

                            condition['id'] = id;

                            if (!mounted) return;

                            setState(() {
                              widget.healthSummary.conditions.add(condition);
                            });
                          } else {
                            final oldCondition =
                                widget.healthSummary.conditions[editingIndex!];

                            condition['id'] = oldCondition['id'];

                            await DatabaseHelper.instance.updateSummaryEntry(
                              'conditions',
                              condition,
                            );

                            if (!mounted) return;

                            setState(() {
                              widget.healthSummary.conditions[editingIndex!] =
                                  condition;
                            });
                          }

                          conditionnameController.clear();
                          conditionnotesController.clear();

                          if (!mounted) return;

                          setState(() {
                            selectedStatus = null;
                            selectedYear = null;
                            editingIndex = null;
                            _isAddingCondition = false;
                          });
                        } catch (e) {
                          debugPrint('Error saving condition: $e');
                        }
                      },
                      child: Text(
                        editingIndex == null
                            ? 'Save Condition'
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
