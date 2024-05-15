import 'package:flutter/material.dart';
import 'weather_page.dart';
import 'chatbot_page.dart';
import 'maskDetection_page.dart';
import 'contacts_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Home page', style: TextStyle(color: Colors.blue, fontSize: 25)))),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('ERRAMI Anas'),
              accountEmail: Text('anaserrami24@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            ListTile(
              title: const Text('Home', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
              leading: const Icon(Icons.home),
            ),
            ListTile(
              title: const Text('Contacts', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactsPage()));
              },
              leading: const Icon(Icons.contacts),
            ),
            ListTile(
              title: const Text('Weather', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherPage()));
              },
              leading: const Icon(Icons.cloud),
            ),
            ListTile(
              title: const Text('ChatBot', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatBotPage()));
              },
              leading: const Icon(Icons.chat),
            ),
            ListTile(
              title: const Text('Mask Detection', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MaskDetectionPage()));
              },
              leading: const Icon(Icons.masks),
            ),
          ],
        ),
      ),
    );
  }
}
