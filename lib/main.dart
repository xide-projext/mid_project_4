import 'dart:convert';
import 'dart:io';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'if_simplescaleanimation.dart';
import 'imagp_simplescaleanimation.dart';
import 'search.dart';
import 'my_page.dart';
import 'nggyu_simplescaleanimation.dart';
import 'goodtime_simplescaleanimation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    SearchScreen(),
    HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Page'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

void main2() {
  runApp(
    MaterialApp(
      title: 'MusiQ',
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/bffhours': (context) => const BFFHoursScreen(),
        '/dramaost': (context) => const DramaOSTScreen(),
        '/foryou': (context) => const ForYouScreen(),
        '/if': (context) => const IfScreen(),
        '/imagp': (context) => const ImagpScreen(),
        '/nggyu': (context) => const NggyuScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.purple,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
    ),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];

  var _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MusiQ'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: ListView(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 60, left: 15),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Playlists',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 15, left: 15),
            child: Row(children: [
              Column(children: [
                GestureDetector(
                  child: Image.network(
                      'https://my-k-toon.web.app/webtoon/1.png',
                      height: 150,
                      width: 150),
                  onTap: () {
                    Navigator.pushNamed(context, '/dramaost');
                  },
                ),
                const Text('Drama OSTs', style: TextStyle(color: Colors.black)),
              ]),
              const SizedBox(width: 30),
              Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Image.network(
                          'https://my-k-toon.web.app/webtoon/2.png',
                          height: 150,
                          width: 150),
                      onTap: () {
                        Navigator.pushNamed(context, '/bffhours');
                      },
                    ),
                    const Text('BFF Hours',
                        style: TextStyle(color: Colors.black))
                  ]),
              const SizedBox(width: 30),
            ])),
        Container(
            margin: const EdgeInsets.only(top: 25, left: 15),
            child: Row(
              children: [
                const Column(children: [
                  Text('For You',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700))
                ]),
                const SizedBox(width: 30),
                Column(
                  children: [
                    GestureDetector(
                      child: const Text('Press to See More',
                          style: TextStyle(color: Colors.purple, fontSize: 15)),
                      onTap: () {
                        Navigator.pushNamed(context, '/foryou');
                      },
                    )
                  ],
                )
              ],
            )),
        SizedBox(
            height: 200.0,
            width: 200.0,
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/bluesky_ikson.jpeg')))),
              const SizedBox(width: 30),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/callmemaybe.jpeg'))),
              ),
              const SizedBox(width: 30),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Wannabe.jpg'))),
              ),
              const SizedBox(width: 30),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/hospitalplaylistcover.jpeg'))),
              ),
              const SizedBox(width: 30),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/Party_in_the_USA.jpg'))),
              ),
              const SizedBox(width: 30),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/Snsd_itnw_cover.png'))),
              ),
            ]))
      ]),
    );
  }
}

class DramaOSTScreen extends StatelessWidget {
  const DramaOSTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Drama OSTs'),
              backgroundColor: const Color.fromARGB(255, 224, 45, 255),
            ),
            body: Center(
                child: ListView(
              children: [
                ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          child: Image.asset('assets/images/if_taeyeon.jpeg'),
                          onTap: () {
                            Navigator.pushNamed(context, '/if');
                          },
                        )),
                    title:
                        const Text('If', style: TextStyle(color: Colors.black)),
                    subtitle: const Text('Taeyeon',
                        style: TextStyle(color: Colors.black)),
                    trailing: GestureDetector(
                      child: const Icon(Icons.play_arrow),
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=RjU5Op_KSBw'));
                      },
                    )),
                ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          child: Image.asset(
                              'assets/images/hospitalplaylistcover.jpeg'),
                          onTap: () {
                            Navigator.pushNamed(context, '/imagp');
                          },
                        )),
                    title: const Text('Introduce Me a Good Person',
                        style: TextStyle(color: Colors.black)),
                    subtitle: const Text('Joy',
                        style: TextStyle(color: Colors.black)),
                    trailing: GestureDetector(
                      child: const Icon(Icons.play_arrow),
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=hoLzH1revMg'));
                      },
                    ))
              ],
            )),
            bottomNavigationBar:
                BottomNavigationBar(items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'My Page')
            ])));
  }
}

class IfScreen extends StatefulWidget {
  const IfScreen({super.key});
  @override
  State<IfScreen> createState() => _IfScreenState();
}

class _IfScreenState extends State<IfScreen> {
  int duration = 1;
  GlobalKey<IfSimpleScaleAnimationState> globalKey =
      GlobalKey<IfSimpleScaleAnimationState>();

  void _incrementCounter() {
    setState(() {
      duration = duration + 1;
      globalKey.currentState?.changeScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('If Album Cover'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IfSimpleScaleAnimation(
              key: globalKey,
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

class ImagpScreen extends StatefulWidget {
  const ImagpScreen({super.key});
  @override
  _ImagpScreenState createState() => _ImagpScreenState();
}

class _ImagpScreenState extends State<ImagpScreen> {
  int duration = 1;
  GlobalKey<ImagpSimpleScaleAnimationState> globalKey =
      GlobalKey<ImagpSimpleScaleAnimationState>();

  void _incrementCounter() {
    setState(() {
      duration = duration + 1;
      globalKey.currentState?.changeScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text('Introduce Me a Good Person Album Cover'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImagpSimpleScaleAnimation(
              key: globalKey,
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

class BFFHoursScreen extends StatelessWidget {
 const BFFHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('BFF Hours'),
              backgroundColor: const Color.fromARGB(255, 224, 45, 255),
            ),
            body: Center(
                child: ListView(
              children: [
                ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          child: Image.asset('assets/images/nggyu.jpeg'),
                          onTap: () {
                            Navigator.pushNamed(context, '/nggyu');
                          },
                        )),
                    title:
                        const Text('Never Gonna Give You Up', style: TextStyle(color: Colors.black)),
                    subtitle: const Text('Rick Astley',
                        style: TextStyle(color: Colors.black)),
                    trailing: GestureDetector(
                      child: const Icon(Icons.play_arrow),
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=dQw4w9WgXcQ'));
                      },
                    )),
                ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child: GestureDetector(
                          child: Image.asset(
                              'assets/images/callmemaybe.jpeg'),
                          onTap: () {
                            Navigator.pushNamed(context, '/imagp');
                          },
                        )),
                    title: const Text('Good Time',
                        style: TextStyle(color: Colors.black)),
                    subtitle: const Text('Owl City and Carly Rae Jepsen',
                        style: TextStyle(color: Colors.black)),
                    trailing: GestureDetector(
                      child: const Icon(Icons.play_arrow),
                      onTap: () {
                        launchUrl(Uri.parse(
                            'https://www.youtube.com/watch?v=H7HmzwI67ec'));
                      },
                    ))
              ],
            )),
            bottomNavigationBar:
                BottomNavigationBar(items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'My Page')
            ])));
  }
}

class NggyuScreen extends StatefulWidget {
  const NggyuScreen({super.key});
  @override
  _NggyuScreenState createState() => _NggyuScreenState();
}

class _NggyuScreenState extends State<NggyuScreen> {
  int duration = 1;
  GlobalKey<NggyuSimpleScaleAnimationState> globalKey =
      GlobalKey<NggyuSimpleScaleAnimationState>();

  void _incrementCounter() {
    setState(() {
      duration = duration + 1;
      globalKey.currentState?.changeScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text('Never Gonna Give You Up Album Cover'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NggyuSimpleScaleAnimation(
              key: globalKey,
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

class GtScreen extends StatefulWidget {
  const GtScreen({super.key});
  @override
  _GtScreenState createState() => _GtScreenState();
}

class _GtScreenState extends State<GtScreen> {
  int duration = 1;
  GlobalKey<GtSimpleScaleAnimationState> globalKey =
      GlobalKey<GtSimpleScaleAnimationState>();

  void _incrementCounter() {
    setState(() {
      duration = duration + 1;
      globalKey.currentState?.changeScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text('Good Time Album Cover'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GtSimpleScaleAnimation(
              key: globalKey,
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

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  _ForYouScreenState createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  void loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    setState(() {
      jsonData = jsonDecode(jsonString)['music'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
            ),
            title: const Text('Drama OSTs'),
            backgroundColor: const Color.fromARGB(255, 224, 45, 255),
          ),
          body: Center(
              child: ListView.builder(
                  itemCount: jsonData.length,
                  itemBuilder: (context, index) {
                    final item = jsonData[index];
                    return ListTile(
                        leading: SizedBox(
                            height: 100,
                            width: 100,
                            child:
                                Image(image: AssetImage(item['albumcover']))),
                        title: Text(item['title'],
                            style: const TextStyle(color: Colors.black)),
                        subtitle: Text(item['artist'],
                            style: const TextStyle(color: Colors.black)),
                        trailing: GestureDetector(
                          child: const Icon(Icons.play_arrow),
                          onTap: () {
                            launchUrl(Uri.parse(item['url']));
                          },
                        ));
                  })),
        ));
  }
}
