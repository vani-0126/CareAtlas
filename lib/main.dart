import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: WelcomePage());
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool animateMain = false;
  bool animateButtons = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        animateMain = true;
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        animateButtons = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Temporary Logo
            AnimatedOpacity(
              opacity: animateMain ? 1.0 : 0.0,
              duration: Duration(milliseconds: 800),
              child: Icon(Icons.explore, size: 70, color: Color(0xFF1E3A8A)),
            ),
            SizedBox(height: 100),
            //Title/App Name
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateMain ? 0 : 20, 0),

              child: AnimatedOpacity(
                opacity: animateMain ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),

                child: Text(
                  "CareAtlas",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Subtitle/Tagline
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateMain ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateMain ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Text(
                  "Understand More. Worry Less!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            //Description
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(0, animateMain ? 0 : 20, 0),
              child: AnimatedOpacity(
                opacity: animateMain ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: Text(
                  "A single place to understand medical information, prepare for appointments, track your health, and organize care.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            //Get Started Button
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateButtons ? 0 : 20,
                0,
              ),

              child: AnimatedOpacity(
                opacity: animateButtons ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 100),
                    textStyle: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeDashboard()),
                    );
                  },
                  child: Text("Get Started"),
                ),
              ),
            ),
            SizedBox(height: 22),
            //Sign In Button
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              transform: Matrix4.translationValues(
                0,
                animateButtons ? 0 : 20,
                0,
              ),

              child: AnimatedOpacity(
                opacity: animateButtons ? 1.0 : 0.0,
                duration: Duration(milliseconds: 800),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF1E3A8A),
                    side: BorderSide(color: Color(0xFF1E3A8A), width: 4),
                    minimumSize: Size(175, 70),
                    textStyle: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Sign In"),
                ),
              ),
            ),
            SizedBox(height: 22),
          ],
        ),
      ),
    );
  } // End of the WelcomePage widget. It contains the UI elements and animations for the welcome screen.
} // This is the main entry point of the application. It sets up the MaterialApp and defines the home page as WelcomePage. The WelcomePage is a stateful widget that displays a welcome screen with animations for the logo, title, subtitle, description, and buttons. The animations are triggered using Future.delayed in the initState method to create a staggered effect when the page loads.

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
