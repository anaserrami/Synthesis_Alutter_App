import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> contacts = [];
  List<bool> selected = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter contact name',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      contacts.add(controller.text);
                      selected.add(false);
                      controller.clear();
                    });
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(contacts[index]),
                  value: selected[index],
                  onChanged: (bool? value) {
                    setState(() {
                      selected[index] = value!;
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                for (int i = selected.length - 1; i >= 0; i--) {
                  if (selected[i]) {
                    contacts.removeAt(i);
                    selected.removeAt(i);
                  }
                }
              });
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
