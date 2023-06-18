import 'package:flutter/material.dart';

void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App - My Page'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      size: 120,
                      color: Color.fromARGB(255, 224, 45, 255),
                    ),
                    onPressed: () {
                      // 계정 아이콘을 눌렀을 때 수행할 동작
                    },
                  ),
                ),
                const SizedBox(
                    height:
                        90), // Add some spacing between the icon and the text
                const Text(
                  '홍길동',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                    height:
                        8), // Add some spacing between the text and the button
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color.fromARGB(160, 224, 45, 255),
                  ),
                  child: const Text('EDIT'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 60, left: 15),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Recentry Played',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 15),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: Image.network(
                                'https://my-k-toon.web.app/webtoon/1.png',
                                height: 150,
                                width: 150,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/playlist',
                                );
                              },
                            ),
                            const Text('Drama OSTs',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            GestureDetector(
                              child: Image.network(
                                'https://my-k-toon.web.app/webtoon/2.png',
                                height: 150,
                                width: 150,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/musicplayer',
                                );
                              },
                            ),
                            const Text('BFF Hours',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25, left: 15),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Shared Playlist',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            GestureDetector(
                              child: const Text(
                                'Press to See More',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/foryou');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/bluesky_ikson.jpeg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/callmemaybe.jpeg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/Wannabe.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'images/hospitalplaylistcover.jpeg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/Party_in_the_USA.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/Snsd_itnw_cover.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Page',
          ),
        ],
      ),
    );
  }
}

class KeyValue<T> {
  final String key;
  T value;

  KeyValue(this.key, this.value);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '계정 편집',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountEditPage(),
    );
  }
}

class AccountEditPage extends StatefulWidget {
  @override
  _AccountEditPageState createState() => _AccountEditPageState();
}

class _AccountEditPageState extends State<AccountEditPage> {
  int currentIndex = 2;

  List<KeyValue<String>> fields = [
    KeyValue('Name', '홍길동'),
    KeyValue('User Name', 'gildong123'),
    KeyValue('Address', '서울특별시 서대문구 연세로50'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계정 편집'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Column(
        children: fields.map((field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  field.key,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.navigate_next,
                  size: 30,
                ),
                title: Text(field.value),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showEditDialog(context, field, (value) {
                      setState(() {
                        field.value = value;
                      });
                    });
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Page',
          ),
        ],
      ),
    );
  }
}

void showEditDialog(BuildContext context, KeyValue<String> field,
    ValueChanged<String> onChanged) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String textValue = field.value;

      return AlertDialog(
        title: Text('${field.key}'),
        content: TextFormField(
          initialValue: textValue,
          onChanged: (value) {
            textValue = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('SAVE'),
            onPressed: () {
              onChanged(textValue);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
