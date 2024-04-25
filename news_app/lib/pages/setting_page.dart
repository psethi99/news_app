import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Settings', style: TextStyle(fontSize: 30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://picsum.photos/250?image=9'),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Michael Faradey', // Replace with the name
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'example@email.com', // Replace with the email or username
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: context.read<ThemeBloc>().state == ThemeMode.dark,
                  onChanged: (value) {
                    context.read<ThemeBloc>().add(ThemeChanged(value));
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {
                    //Logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Account',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildAccountButton(
                context, 'Edit Account', Icons.arrow_forward_ios),
            const SizedBox(height: 15),
            _buildAccountButton(
                context, 'Change Password', Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountButton(
      BuildContext context, String label, IconData icon) {
    return InkWell(
      onTap: () {
        // Logic for button action
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
