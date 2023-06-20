import 'dart:convert';
import 'dart:io';
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
    MainScreen(),
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

class Music {
  String title;
  String artist;
  int duration;

  Music({required this.title, required this.artist, required this.duration});

  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      title: json['title'],
      artist: json['artist'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
    };
  }
}

class MusicPlayerApp extends StatefulWidget {
  const MusicPlayerApp({super.key});

  @override
  _MusicPlayerAppState createState() => _MusicPlayerAppState();
}

class _MusicPlayerAppState extends State<MusicPlayerApp> {
  List<Music> playlist = [];

  @override
  void initState() {
    super.initState();
    readInstance();
  }

  void readInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? playlistJson = prefs.getString('playlist');
    if (playlistJson != null) {
      List<dynamic> playlistData = jsonDecode(playlistJson);
      setState(() {
        playlist = playlistData.map((item) => Music.fromJson(item)).toList();
      });
    }
  }

  void saveInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String playlistJson =
        jsonEncode(playlist.map((music) => music.toJson()).toList());
    prefs.setString('playlist', playlistJson);
  }

  void addMusicToPlaylist() {
    Music music = Music(
      title: 'Song Title',
      artist: 'Artist Name',
      duration: 210,
    );
    setState(() {
      playlist.add(music);
    });
    saveInstance();
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
          title: const Text('Drama OSTs'),
          backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Column(
        children: [
          Row(children: [
            ElevatedButton(
              onPressed: addMusicToPlaylist,
              child: const Text('Add Music to Playlist'),
            ),
            ElevatedButton(
                child: const Text('Add Manually'),
                onPressed: () => Navigator.pushNamed(context, '/form'))
          ]),
          Expanded(
            child: ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                Music music = playlist[index];
                return ListTile(
                  title: Text(music.title),
                  subtitle: Text(music.artist),
                  trailing: Text('${music.duration} sec'),
                );
              },
            ),
          ),
        ],
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
        '/musicplayer': (context) => const MusicPlayerApp(),
        '/dramaost': (context) => const DramaOSTScreen(),
        '/foryou': (context) => const ForYouScreen(),
        '/form': (context) => const TextFormScreen(),
        '/if': (context) => const IfScreen(),
        '/imagp': (context) => const ImagpScreen(),
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
                  const Text('Drama OSTs',
                      style: TextStyle(color: Colors.black)),
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
                          Navigator.pushNamed(context, '/musicplayer');
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
                  Column(children: const [
                    Text('For You',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w700))
                  ]),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      GestureDetector(
                        child: const Text('Press to See More',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 15)),
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
                            image: AssetImage('assets/images/bluesky_ikson.jpeg')))),
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
                          image:
                              AssetImage('assets/images/hospitalplaylistcover.jpeg'))),
                ),
                const SizedBox(width: 30),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Party_in_the_USA.jpg'))),
                ),
                const SizedBox(width: 30),
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Snsd_itnw_cover.png'))),
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
                        child: GestureDetector(child:Image.asset('assets/images/if_taeyeon.jpeg'),
                        onTap: () {
                          Navigator.pushNamed(context, '/if');
                        },)),
                    title:
                        const Text('If', style: TextStyle(color: Colors.black)),
                    subtitle: const Text('Taeyeon',
                        style: TextStyle(color: Colors.black)),
                    trailing: GestureDetector(child: const Icon(Icons.play_arrow),
                    onTap: () {
                      launchUrl(Uri.parse('https://www.youtube.com/watch?v=RjU5Op_KSBw'));
                    },)),
                ListTile(
                    leading: SizedBox(
                        height: 100,
                        width: 100,
                        child:
                            GestureDetector(child: Image.asset('assets/images/hospitalplaylistcover.jpeg'),
                            onTap: () {
                              Navigator.pushNamed(context, '/imagp');
                            },)),
                    title: const Text('Introduce Me a Good Person',
                        style: TextStyle(color: Colors.black)),
                    subtitle: const Text('Joy',
                        style: TextStyle(color: Colors.black)),
                    trailing: GestureDetector(child: const Icon(Icons.play_arrow),
                    onTap: (){
                      launchUrl(Uri.parse('https://www.youtube.com/watch?v=hoLzH1revMg'));
                    },))
              ],
            )),));
  }
}

class IfScreen extends StatefulWidget{
  const IfScreen({super.key});
  @override
  State<IfScreen> createState() => _IfScreenState();
}

class _IfScreenState extends State<IfScreen> {
  int duration = 1;
  GlobalKey<IfSimpleScaleAnimationState> globalKey = GlobalKey<IfSimpleScaleAnimationState>();

  void _incrementCounter() {
    setState(() {
      duration = duration + 1;
      globalKey.currentState?.changeScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Drama OSTs'),
          backgroundColor: const Color.fromARGB(255, 224, 45, 255),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[IfSimpleScaleAnimation(key: globalKey,),],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),),
    );
  }
}

class ImagpScreen extends StatefulWidget{
  const ImagpScreen({super.key});
  @override
  _ImagpScreenState createState() => _ImagpScreenState();
}

class _ImagpScreenState extends State<ImagpScreen> {
  int duration = 1;
  GlobalKey<ImagpSimpleScaleAnimationState> globalKey = GlobalKey<ImagpSimpleScaleAnimationState>();

  void _incrementCounter() {
    setState(() {
      duration = duration + 1;
      globalKey.currentState?.changeScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          title: const Text('Drama OSTs'),
          backgroundColor: const Color.fromARGB(255, 224, 45, 255),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ImagpSimpleScaleAnimation(key: globalKey,),],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),),
    );
  }
}

class ForYouScreen extends StatefulWidget{
  const ForYouScreen({super.key});

  @override
  _ForYouScreenState createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  List<dynamic> jsonData = [];

  @override
  void initState(){
    super.initState();
    loadJsonData();
  }

  void loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/db.json');
    setState(() { jsonData = jsonDecode(jsonString)['music'];
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
                    return ListTile(leading: SizedBox(height: 100, 
                    width: 100, 
                    child: Image(image: AssetImage(item['albumcover']))),
                    title: Text(item['title'],style: const TextStyle(color: Colors.black)),
                    subtitle: Text(item['artist'],style: const TextStyle(color: Colors.black)),
                    trailing: GestureDetector(child: const Icon(Icons.play_arrow),
                    onTap: () {
                      launchUrl(Uri.parse(item['url']));
                    },)
                    );
                  }
            )),
            ));
  }
}

class TextFormScreen extends StatefulWidget {
  const TextFormScreen({Key? key}) : super(key: key);
  @override
  State<TextFormScreen> createState() => _TextFormScreenState();
}

class _TextFormScreenState extends State<TextFormScreen> {
  final musicProfile = MusicProfile(name: '', artist: '');
  final mvProfile = MvProfile(name: '', artist: '', url: '');

  void updateMusicProfile(MusicProfile profile) {
    setState(() {
      musicProfile.name = profile.name;
      musicProfile.artist = profile.artist;
    });
  }

  void updateMvProfile(MvProfile profile) {
    setState(() {
      mvProfile.name = profile.name;
      mvProfile.artist = profile.artist;
      mvProfile.url = profile.url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstProfilePage(
              musicProfile: musicProfile,
              mvProfile: mvProfile,
            ),
        '/musicProfileForm': (context) => MusicProfileForm(
              userProfile: musicProfile,
              updateProfile: updateMusicProfile,
            ),
        '/mvProfileForm': (context) => MvProfileForm(
              userProfile: mvProfile,
              updateProfile: updateMvProfile,
            ),
      },
    );
  }
}

class UserProfile {
  String name;
  String artist;

  UserProfile({required this.name, required this.artist});
}

class MusicProfile extends UserProfile {
  MusicProfile({
    required String name,
    required String artist,
  }) : super(name: name, artist: artist);
}

class MvProfile extends UserProfile {
  String url;

  MvProfile({
    required String name,
    required String artist,
    required this.url,
  }) : super(name: name, artist: artist);
}

class FirstProfilePage extends StatelessWidget {
  final MusicProfile musicProfile;
  final MvProfile mvProfile;

  const FirstProfilePage({
    super.key,
    required this.musicProfile,
    required this.mvProfile,
  });

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
          title: const Text('Drama OSTs'),
          backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/musicProfileForm');
                },
                child: const Text('Add Music'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/mvProfileForm');
                },
                child: const Text('Add Music Video'),
              ),
            ],
          ),
          if (musicProfile.name.isNotEmpty)
            Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add your music:'),
                      Text('Name: ${musicProfile.name}'),
                      Text('Artist: ${musicProfile.artist}'),
                    ],
                  )),
            ),
          if (mvProfile.name.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Add your music video:'),
                    Text('Name: ${mvProfile.name}'),
                    Text('Artist: ${mvProfile.artist}'),
                    Text('URL: ${mvProfile.url}'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MusicProfileForm extends StatefulWidget {
  final UserProfile userProfile;
  final Function(MusicProfile) updateProfile;

  const MusicProfileForm({
    Key? key,
    required this.userProfile,
    required this.updateProfile,
  }) : super(key: key);

  @override
  _MusicProfileFormState createState() => _MusicProfileFormState();
}

class _MusicProfileFormState extends State<MusicProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _musicProfile = MusicProfile(name: '', artist: '');
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
          title: const Text('Drama OSTs'),
          backgroundColor: const Color.fromARGB(255, 224, 45, 255),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the song title';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _musicProfile.name = value!;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Artist'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the artist';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _musicProfile.artist = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Processing Data'),
                    ));
                    widget.updateProfile(_musicProfile);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Music'),
              )
            ],
          ),
        ));
  }
}

class MvProfileForm extends StatefulWidget {
  final UserProfile userProfile;
  final Function(MvProfile) updateProfile;

  const MvProfileForm({
    Key? key,
    required this.userProfile,
    required this.updateProfile,
  }) : super(key: key);

  @override
  _MvProfileFormState createState() => _MvProfileFormState();
}

class _MvProfileFormState extends State<MvProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _mvProfile = MvProfile(name: '', artist: '', url: '');

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
          title: const Text('Drama OSTs'),
          backgroundColor: const Color.fromARGB(255, 224, 45, 255),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the music video';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _mvProfile.name = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Artist'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the artist';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _mvProfile.artist = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pleasee enter the URL';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _mvProfile.url = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      widget.updateProfile(_mvProfile);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Music Video'),
                )
              ],
            )));
  }
}