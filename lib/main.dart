import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';

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
    String playlistJson = jsonEncode(playlist.map((music) => music.toJson()).toList());
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
        title: const Text('New Playlist'),
        backgroundColor:  const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Column(
        children: [
          Row(children: [ElevatedButton(
            onPressed: addMusicToPlaylist,
            child: const Text('Add Music to Playlist'),
          ),
          ElevatedButton(child: 
          const Text('Add Manually'),
          onPressed: () => Navigator.pushNamed(context, '/form'))]),
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

void main() {
  runApp(MaterialApp(
    title: 'MusiQ',
    initialRoute: '/',
    routes: {
      '/': (context) => const MainScreen(),
      '/musicplayer': (context) => const MusicPlayerApp(),
      '/playlist': (context) => const PlaylistScreen(),
      '/foryou': (context) => const ForYouScreen(),
      '/form': (context) => const TextFormScreen(),
      '/bluesky':(context) => const BlueSky(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MusiQ'),
        backgroundColor:  const Color.fromARGB(255, 224, 45, 255),
      ),
      body: ListView(
        children: <Widget>[
          Container(margin: const EdgeInsets.only(top: 60, left: 15),
            child: const Align(
            alignment: Alignment.topLeft,
            child: Text('Your Playlists', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ), 
          ),
          Container(margin: const EdgeInsets.only(top: 15, left: 15),
            child: Row(
              children: [
                Column(children: [
                  GestureDetector(
                  child: Image.network('https://my-k-toon.web.app/webtoon/1.png',
                    height: 150,
                    width: 150),
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/playlist');
                    },
                  ),
                  const Text('Drama OSTs',style: TextStyle(color: Colors.black)),
              ]),
                const SizedBox(width: 30),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  GestureDetector(
                  child: Image.network('https://my-k-toon.web.app/webtoon/2.png',
                    height: 150,
                    width: 150),
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/musicplayer');
                    },
                  ),
                  const Text('BFF Hours',style: TextStyle(color: Colors.black))
                ]),
                const SizedBox(width: 30),
                ]
              )
            ),
            Container(margin: const EdgeInsets.only(top: 25, left: 15),
              child: Row(
                children: [
                  const Column(
                    children: [
                      Text('For You',
                      style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w700))
                    ]),
                  const SizedBox(width: 20),
                  Column(children: [
                    GestureDetector(child: const Text('Press to See More',style: TextStyle(color: Colors.purple, fontSize: 15)),
                      onTap: (){
                        Navigator.pushNamed(context, '/foryou');
                      },)
                  ],)
                ],
              )
            ),
            SizedBox(height: 200.0, width: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/bluesky_ikson.jpeg'))
                    )
                  ),
                  const SizedBox(width: 30), 
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/callmemaybe.jpeg'))
                    ),
                  ),
                  const SizedBox(width: 30), 
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/Wannabe.jpg'))
                    ),
                  ),
                  const SizedBox(width: 30), 
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/hospitalplaylistcover.jpeg'))
                    ),
                  ),
                  const SizedBox(width: 30), 
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/Party_in_the_USA.jpg'))
                    ),
                  ),
                  const SizedBox(width: 30), 
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/Snsd_itnw_cover.png'))
                    ),
                  ),
                ]
              ))
          ]
        ),
        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search),
        label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person),
        label: 'My Page')
      ])
    );
  }
}

class PlaylistScreen extends StatelessWidget{
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Drama OSTs'),
        backgroundColor:  const Color.fromARGB(255, 224, 45, 255),
        ),
        body: Center(
        child: ListView(
          children: [
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/if_taeyeon.jpeg')
            ),
            title: const Text('If', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Taeyeon', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/hospitalplaylistcover.jpeg')
            ),
            title: const Text('Introduce Me a Good Person', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Joy', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow))
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search),
        label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person),
        label: 'My Page')
      ])
      )
    );
  }
}

class ForYouScreen extends StatelessWidget{
  const ForYouScreen({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: const Text('For You'),
        backgroundColor:  const Color.fromARGB(255, 224, 45, 255),
        ),
        body: Center(
        child: ListView(
          children: [
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/bluesky_ikson.jpeg')
            ),
            title: const Text('Blue Sky', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Ikson', style: TextStyle(color: Colors.black)),
            trailing: GestureDetector(
              child: const Icon(Icons.play_arrow),
              onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/bluesky');
                    },)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/callmemaybe.jpeg')
            ),
            title: const Text('Call Me Maybe', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Carly Rae Jepsen', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/Wannabe.jpg')
            ),
            title: const Text('Wannabe', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Spice Girls', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/hospitalplaylistcover.jpeg')
            ),
            title: const Text('Aloha', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Jo Jung Suk', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/Party_in_the_USA.jpg')
            ),
            title: const Text('Party in the USA', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Miley Cyrus', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/Snsd_itnw_cover.png')
            ),
            title: const Text('Into the New World', style: TextStyle(color: Colors.black)),
            subtitle: const Text("Girls' Generation", style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/ts_red.png')
            ),
            title: const Text('Red', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Taylor Swift', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/PolaroidJonasBlue.jpg')
            ),
            title: const Text('Polaroid', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Jonas Blue', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ListTile(
            leading: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/1989.png')
            ),
            title: const Text('Style', style: TextStyle(color: Colors.black)),
            subtitle: const Text('Taylor Swift', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.play_arrow)),
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),
        label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search),
        label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person),
        label: 'My Page')
      ])
      )
    );
}}

class BlueSky extends StatefulWidget{
  const BlueSky({super.key});

  @override
  _BlueSkyState createState() => _BlueSkyState();
}

class _BlueSkyState extends State<BlueSky> with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController _animationController;

  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(vsync: this,
    duration: const Duration(seconds: 5),);
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    });
  }
  @override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Now Playing: Blue Sky'), backgroundColor:  const Color.fromARGB(255, 224, 45, 255)),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(turns: _animationController,
          child: const CircleAvatar(backgroundImage: AssetImage('images/bluesky_ikson.jpeg'),
          radius: 100,),),
          const SizedBox(height: 16),
          IconButton(icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
          size: 48,),
          onPressed: togglePlayPause,)
        ],
      )
    ));
}
}

class TextFormScreen extends StatefulWidget{
  const TextFormScreen({Key? key}) : super(key: key);
  @override
  State<TextFormScreen> createState() => _TextFormScreenState();
}

class _TextFormScreenState extends State<TextFormScreen>{
  final musicProfile = MusicProfile(name: '', artist: '');
  final mvProfile = MvProfile(name: '', artist: '', url: '');

  void updateMusicProfile(MusicProfile profile){
    setState(() {
      musicProfile.name = profile.name;
      musicProfile.artist = profile.artist;
    });
  }

  void updateMvProfile(MvProfile profile){
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
      theme: ThemeData(primarySwatch: Colors.purple,),
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

class MusicProfile extends UserProfile{
  
  MusicProfile({
    required String name,
    required String artist,
  }) : super(name: name, artist: artist);
}

class MvProfile extends UserProfile{
  String url;

  MvProfile({
    required String name,
    required String artist,
    required this.url,
  }) : super(name: name, artist: artist);
}

class FirstProfilePage extends StatelessWidget{
  final MusicProfile musicProfile;
  final MvProfile mvProfile;

  const FirstProfilePage({super.key, 
    required this.musicProfile,
    required this.mvProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select something to add'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/musicProfileForm');
              }, child: const Text('Add Music'),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/mvProfileForm');
              }, child: const Text('Add Music Video'),
              ),
            ],
          ),
          if (musicProfile.name.isNotEmpty)
          Card(
            child: Padding(padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [const Text('Add your music:'),
            Text('Name: ${musicProfile.name}'),
            Text('Artist: ${musicProfile.artist}'),
            ],)),
          ),
          if (mvProfile.name.isNotEmpty)
          Card(child: Padding(padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add your music video:'),
              Text('Name: ${mvProfile.name}'),
              Text('Artist: ${mvProfile.artist}'),
              Text('URL: ${mvProfile.url}'),
            ],
          ),),),
        ],
      ),
    );
  }
}

class MusicProfileForm extends StatefulWidget{
  final UserProfile userProfile;
  final Function(MusicProfile) updateProfile;

  const MusicProfileForm({
    Key? key,
    required this.userProfile,
    required this.updateProfile,
  }) : super(key: key);

  @override
  _MusicProfileFormState createState()=> _MusicProfileFormState();
}

class _MusicProfileFormState extends State<MusicProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _musicProfile = MusicProfile(name: '', artist: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add your music'),),
      body: Form(key: _formKey,
      child: Column(children: <Widget>[
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
        ElevatedButton(onPressed: (){
          if (_formKey.currentState!.validate()){
            _formKey.currentState!.save();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data'),)
            );
            widget.updateProfile(_musicProfile);
            Navigator.pop(context);
          }
        }, child: const Text('Add Music'),)
      ],),)
    );
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
      appBar: AppBar(title: const Text('Add a music video'),),
      body: Form(key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(decoration: const InputDecoration(labelText: 'Name'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the name of the music video';
          }
          return null;
        },
        onSaved: (value){
          setState(() {
            _mvProfile.name = value!;
          });
        },),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Artist'),
          validator: (value){
            if (value == null || value.isEmpty){
              return 'Please enter the name of the artist';
            }
            return null;
          },
          onSaved: (value){
            setState(() {
              _mvProfile.artist = value!;
            });
          },
        ),
        TextFormField(
          decoration: const InputDecoration(labelText: 'URL'),
          validator: (value) {
            if (value == null || value.isEmpty){
              return 'Pleasee enter the URL';
            }
            return null;
          },
          onSaved: (value){
            setState(() {
              _mvProfile.url = value!;
            });
          },
        ),
        ElevatedButton(onPressed: (){
          if (_formKey.currentState!.validate()){
            _formKey.currentState!.save();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')),);
            widget.updateProfile(_mvProfile);
            Navigator.pop(context);
          }
        }, child: const Text('Add Music Video'),)
      ],))
    );
  }
}
