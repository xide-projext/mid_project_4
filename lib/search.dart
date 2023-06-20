import 'package:flutter/material.dart';
import 'main.dart';
import 'my_page.dart';

void main() {
  runApp(SearchPage());
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    SearchScreen(),
    HomePage(),
  ];

  void _navigateToSearchList(String searchText) {
    if (searchText.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchListScreen(searchText: searchText),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Page',
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final int initialIndex;

  SearchScreen({this.initialIndex = 1});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> data = [
    'If',
    'Introduce Me a Good Person',
    'Some Other Song',
    'Another Song',
  ];

  List<String> filteredData = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    filteredData.addAll(data);
    super.initState();
  }

  void _filterSearchResults(String query) {
    List<String> dummySearchList = List<String>.from(data);
    if (query.isNotEmpty) {
      List<String> searchList = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          searchList.add(item);
        }
      });
      setState(() {
        filteredData.clear();
        filteredData.addAll(searchList);
      });
    } else {
      setState(() {
        filteredData.clear();
        filteredData.addAll(data);
      });
    }
  }

  void _onSearchResultTap(String searchItem) {
    _searchController.text = searchItem;
    _navigateToSearchList(searchItem);
  }

  void _navigateToSearchList(String searchText) {
    if (searchText.isNotEmpty) {
      Navigator.pushNamed(context, '/searchList', arguments: searchText);
    }
  }

  void _onSearchButtonPressed() {
    final String searchText = _searchController.text;
    _navigateToSearchList(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MusiQ - Search'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                _navigateToSearchList(value);
              },
              onChanged: (value) {
                _filterSearchResults(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredData[index]),
                  onTap: () {
                    _onSearchResultTap(filteredData[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: const Center(
        child: Text('My Page Screen'),
      ),
    );
  }
}

class SearchListScreen extends StatelessWidget {
  final String searchText;

  SearchListScreen({required this.searchText});

  @override
  Widget build(BuildContext context) {
    final String searchText = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KPOP 의 검색결과'),
        backgroundColor: const Color.fromARGB(255, 224, 45, 255),
      ),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('images/if_taeyeon.jpeg'),
              ),
              title: Text(searchText, style: const TextStyle(color: Colors.black)),
              subtitle: const Text('Taeyeon', style: TextStyle(color: Colors.black)),
              trailing: const Icon(Icons.play_arrow),
            ),
            ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('images/hospitalplaylistcover.jpeg'),
              ),
              title: Text(searchText, style: const TextStyle(color: Colors.black)),
              subtitle: const Text('Joy', style: TextStyle(color: Colors.black)),
              trailing: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
