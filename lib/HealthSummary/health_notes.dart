import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/health_summary.dart';
import 'package:health_bridge/HealthSummary/my_health_summary_page.dart';
import 'package:health_bridge/Database/database_helper.dart';

class HealthNotes extends StatefulWidget {
  final HealthSummary healthSummary;
  final bool fromManagmentScreen;

  const HealthNotes({
    super.key,
    required this.healthSummary,
    this.fromManagmentScreen = false,
  });
  @override
  State<HealthNotes> createState() => HealthNotesState();
}

class HealthNotesState extends State<HealthNotes> {
  final TextEditingController healthNoteController = TextEditingController();
  int? editingIndex5; // variable that holds the index of note being edited

  @override
  void dispose() {
    healthNoteController.dispose();
    super.dispose();
  }

  Future<void> loadHealthNotes() async {
    final savedNotes = await DatabaseHelper.instance.getSummaryEntries(
      'health_notes',
    );

    if (!mounted) return;

    setState(() {
      widget.healthSummary.notes
        ..clear()
        ..addAll(savedNotes);
    });
  }

  @override
  void initState() {
    super.initState();
    loadHealthNotes();
  }

  bool _isAddingNote = false;

  @override
  Widget build(BuildContext context) {
    return _isAddingNote ? buildAddNoteForm() : buildAddNoteTile();
  }

  Widget buildNoteCard(Map<String, dynamic> note, int index) {
    return Card(
      color: const Color.fromARGB(255, 246, 208, 253),
      elevation: 10,
      child: ListTile(
        subtitle: Column(
          children: [
            Text('Health Note: ${note['notes'] ?? ''}'),

            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'edit') {
                  setState(() {
                    editingIndex5 = index;
                    healthNoteController.text = note['notes'] ?? '';
                    _isAddingNote = true;
                  });
                } else if (value == 'delete') {
                  final id = note['id'];

                  if (id != null) {
                    await DatabaseHelper.instance.deleteSummaryEntry(
                      'health_notes',
                      id as int,
                    );
                  }

                  if (!mounted) return;

                  setState(() {
                    widget.healthSummary.notes.removeAt(index);
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

  Widget buildAddNoteTile() {
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
              "Extra Health Notes",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add any other health information you would like to include in your summary or click done to move on!",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),

            for (int i = 0; i < widget.healthSummary.notes.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: buildNoteCard(widget.healthSummary.notes[i], i),
              ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingNote = true; // Show the input fields
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
                          "Add a Health Note",
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
                    // Navigate to the next page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        settings: const RouteSettings(name: 'healthSummary'),
                        builder: (context) => MyHealthSummary(
                          healthSummary: widget.healthSummary,
                        ),
                      ),
                      (route) => route.isFirst, // Remove all previous routes
                    );
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

  Widget buildAddNoteForm() {
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
              "Extra Health Notes",
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 72, 26, 102),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Add any other health information you would like to include in your summary or click done to move on!",
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
                      controller: healthNoteController,
                      minLines: 4,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        labelText: 'Health Note',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText:
                            'Add any other health information you would like to include...',
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
                        final note = <String, dynamic>{
                          'notes': healthNoteController.text,
                        };

                        if (editingIndex5 == null) {
                          // Insert a new note.
                          final id = await DatabaseHelper.instance
                              .insertSummaryEntry('health_notes', note);

                          note['id'] = id;

                          if (!mounted) return;

                          setState(() {
                            widget.healthSummary.notes.add(note);
                          });
                        } else {
                          // Update the existing note.
                          final oldNote =
                              widget.healthSummary.notes[editingIndex5!];
                          note['id'] = oldNote['id'];

                          if (note['id'] != null) {
                            await DatabaseHelper.instance.updateSummaryEntry(
                              'health_notes',
                              note,
                            );
                          } else {
                            // Handle an existing note without a database ID.
                            final id = await DatabaseHelper.instance
                                .insertSummaryEntry('health_notes', note);

                            note['id'] = id;
                          }

                          if (!mounted) return;

                          setState(() {
                            widget.healthSummary.notes[editingIndex5!] = note;
                          });
                        }

                        healthNoteController.clear();

                        setState(() {
                          editingIndex5 = null;
                          _isAddingNote = false;
                        });
                      },
                      child: Text(
                        editingIndex5 == null
                            ? 'Save Health Note'
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
