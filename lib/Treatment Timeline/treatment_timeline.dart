import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_bridge/Database/database_helper.dart';
import 'package:health_bridge/Dashboards/track_dashboard.dart';
import 'package:health_bridge/Treatment%20Timeline/treatment_event.dart';

class TreatmentTimeline extends StatefulWidget {
  const TreatmentTimeline({super.key});
  @override
  State<TreatmentTimeline> createState() => _TreatmentTimelineState();
}

class _TreatmentTimelineState extends State<TreatmentTimeline> {
  List<TreatmentEvent> events = [];
  bool _isAddingEvent = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _eventNotesController = TextEditingController();
  final List<String> eventType = [
    "Appointment",
    "Treatment",
    "Test",
    "Procedure",
    "Other",
  ];
  TreatmentEvent? _editingEvent;
  String selectedType = "Appointment";
  TimeOfDay? selectedTime;
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void editEvent(TreatmentEvent event) {
    setState(() {
      _editingEvent = event;

      _titleController.text = event.title;
      _eventNotesController.text = event.notes ?? "";

      selectedType = event.type;
      selectedDate = event.date;

      _isAddingEvent = true;
    });
  }

  Future<void> loadTreatmentEvents() async {
    try {
      final savedEvents = await DatabaseHelper.instance.getTreatmentEvents();

      if (!mounted) return;

      setState(() {
        events = savedEvents;
      });
    } catch (e) {
      debugPrint('Error loading treatment events: $e');
    }
  }

  Future<void> pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Map<int, List<TreatmentEvent>> groupEventsByYear() {
    Map<int, List<TreatmentEvent>> groupedEvents = {};

    for (TreatmentEvent event in events) {
      int year = event.date.year;
      if (!groupedEvents.containsKey(year)) {
        groupedEvents[year] = [];
      }
      groupedEvents[year]!.add(event);
    }
    return groupedEvents;
  }

  @override
  void initState() {
    super.initState();
    loadTreatmentEvents();
  }

  @override
  Widget build(BuildContext context) {
    return _isAddingEvent ? buildAddEventForm() : buildAddEventTile();
  }

  Widget buildAddEventTile() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 250, 196),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 193, 250, 196),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "My Treatment Timeline",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 64, 161, 115),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Organize important medical events in one timeline, from past treatments to upcoming appointments.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 64, 161, 115),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 20),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isAddingEvent = true; // Show the input fields
                  });
                },
                borderRadius: BorderRadius.circular(35),
                splashColor: Colors.white.withValues(),
                highlightColor: Colors.white.withValues(),
                child: Card(
                  color: const Color.fromARGB(255, 33, 180, 92),
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
                        Icon(
                          Icons.add,
                          size: 35,
                          color: const Color.fromARGB(255, 17, 61, 27),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Add an Event",
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 17, 61, 27),
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
            SizedBox(height: 40),
            buildUpcomingEvents(),

            SizedBox(height: 30),
            buildPastEvents(),
          ],
        ),
      ),
    );
  }

  Widget buildUpcomingEvents() {
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    List<TreatmentEvent> upcomingEvents = events
        .where((event) => !event.date.isBefore(today))
        .toList();

    upcomingEvents.sort((a, b) => a.date.compareTo(b.date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming Events",
          style: GoogleFonts.inter(
            color: const Color.fromARGB(255, 64, 161, 115),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        ...upcomingEvents.map((event) => buildEventCard(event)),
      ],
    );
  }

  Widget buildEventCard(TreatmentEvent event) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(event.type),

              Text("${event.date.month}/${event.date.day}/${event.date.year}"),

              if (event.time != null) Text(event.time!),

              if (event.notes != null) Text(event.notes!),

              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'edit') {
                    editEvent(event);
                  } else if (value == 'delete') {
                    if (event.id == null) return;

                    await DatabaseHelper.instance.deleteTreatmentEvent(
                      event.id!,
                    );

                    if (!mounted) return;

                    setState(() {
                      events.removeWhere((item) => item.id == event.id);
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

  Widget buildPastEvents() {
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    List<TreatmentEvent> pastEvents = events
        .where((event) => event.date.isBefore(today))
        .toList();

    Map<int, List<TreatmentEvent>> eventsByYear = {};

    for (TreatmentEvent event in pastEvents) {
      int year = event.date.year;

      if (!eventsByYear.containsKey(year)) {
        eventsByYear[year] = [];
      }

      eventsByYear[year]!.add(event);
    }

    List<int> years = eventsByYear.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Past Events",
          style: GoogleFonts.inter(
            color: const Color.fromARGB(255, 64, 161, 115),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        ...years.map((year) {
          return ExpansionTile(
            title: Text(
              "$year",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            children: eventsByYear[year]!
                .map((event) => buildEventCard(event))
                .toList(),
          );
        }),
      ],
    );
  }

  Widget buildAddEventForm() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 250, 196),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 193, 250, 196),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "My Treatment Timeline",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 64, 161, 115),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Organize important medical events in one timeline, from past treatments to upcoming appointments.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 64, 161, 115),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 40),
            Card(
              color: const Color.fromARGB(255, 33, 180, 92),
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Blood Test',
                        labelText: 'Event Name',
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
                    children: eventType.map((status) {
                      return ChoiceChip(
                        label: Text(status),
                        selected:
                            selectedType ==
                            status, // You can manage selection state here
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedType = status;
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
                      selectedDate == null
                          ? "Select Date"
                          : "${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}",
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
                      selectedTime == null
                          ? "Select Time"
                          : selectedTime!.format(context),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventNotesController,
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
                        backgroundColor: const Color.fromARGB(255, 33, 83, 40),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                        textStyle: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () async {
                        if (_titleController.text.isEmpty ||
                            selectedDate == null) {
                          return;
                        }

                        try {
                          if (_editingEvent != null) {
                            // Update the existing event
                            final event = _editingEvent!;

                            event.title = _titleController.text;
                            event.notes = _eventNotesController.text;
                            event.type = selectedType;
                            event.date = selectedDate!;
                            event.time = selectedTime?.format(context);

                            await DatabaseHelper.instance.updateTreatmentEvent(
                              event,
                            );

                            if (!mounted) return;

                            setState(() {
                              _editingEvent = null;
                              _isAddingEvent = false;
                            });
                          } else {
                            // Save a new event to the database
                            final newEvent = TreatmentEvent(
                              title: _titleController.text,
                              type: selectedType,
                              date: selectedDate!,
                              time: selectedTime?.format(context),
                              notes: _eventNotesController.text,
                            );

                            final id = await DatabaseHelper.instance
                                .insertTreatmentEvent(newEvent);

                            newEvent.id = id;

                            if (!mounted) return;

                            setState(() {
                              events.add(newEvent);
                              _isAddingEvent = false;
                            });
                          }

                          _titleController.clear();
                          _eventNotesController.clear();
                          selectedDate = null;
                          selectedTime = null;
                          selectedType = "Appointment";

                          setState(() {
                            _editingEvent = null;
                          });
                        } catch (e) {
                          debugPrint('Error saving treatment event: $e');
                        }
                      },
                      child: Text(
                        _editingEvent != null ? "Update Event" : "Save Event",
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
