import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'bloc/event.dart';
import 'bloc/state.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dark Mode'),
            BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                bool isDarkMode = false;
                if (state is DarkModeChanged) {
                  isDarkMode = state.isDarkMode;
                }
                return Switch(
                  value: isDarkMode,
                  onChanged: (_) {
                    BlocProvider.of<DataBloc>(context).add(ToggleDarkMode());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
