import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/setting_page.dart';
import 'package:news_app/theme.dart';
import 'bloc/news_bloc.dart';
import 'bloc/theme_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc()..add(FetchNews()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state,
          title: 'News App',
          home: MainNavigation(),
        );
      }),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          WidgetBuilder? builder;
          switch (settings.name) {
            case '/':
              builder = (context) => HomeView();
              break;
            case '/search':
              break;
            case '/favorite':
              break;
            case '/settings':
              builder = (context) => SettingsPage();
              break;
            default:
              builder = null;
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(
              builder: builder ?? (context) => Container(), settings: settings);
        },
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
            icon: Icon(Icons.bookmark),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
        switch (index) {
          case 0:
            _navigatorKey.currentState!.pushReplacementNamed('/');
            break;
          case 1:
            _navigatorKey.currentState!.pushReplacementNamed('/search');
            break;
          case 2:
            _navigatorKey.currentState!.pushReplacementNamed('/favorite');
            break;
          case 3:
            _navigatorKey.currentState!.pushReplacementNamed('/settings');
            break;
          default:
            break;
        }
      });
    }
  }
}
