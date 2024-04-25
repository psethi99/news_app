import 'package:assignment_prakhil/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';
import 'description.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          return ImageSlider(images: state.images);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ),
    Container(child: Center(child: Text('Search'))),
    Container(child: Center(child: Text('Favorites'))),
    Container(child: Center(child: Text('Setting'))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
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
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              if (index == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              }
            });
          }),
    );
  }
}

class ImageSlider extends StatelessWidget {
  final List<String> images;

  ImageSlider({required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/description',
                arguments: DescriptionArguments(
                    image: images[index], description: "Description here"));
          },
          child: Image.network(images[index].toString()),
        );
      },
    );
  }
}
