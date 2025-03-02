import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Contacts_Provider.dart';
import 'contact_dialog.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes Contacts"),
      centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (groupId) {
              // Si "Tous" est sélectionné, on affiche tous les contacts
              if (groupId == 0) {
                Provider.of<ContactProvider>(context, listen: false).fetchContacts();
              } else {
                Provider.of<ContactProvider>(context, listen: false).filterContacts(groupId);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text("Tous")),
              PopupMenuItem(value: 1, child: Text("Amis")),
              PopupMenuItem(value: 2, child: Text("Famille")),
              PopupMenuItem(value: 3, child: Text("Travail")),
              PopupMenuItem(value: 4, child: Text("Camarade")),
              PopupMenuItem(value: 5, child: Text("Connaissance")),
            ],
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) {
          return provider.contacts.isEmpty
              ? Center(child: Text("Aucun contact trouvé"))
              : ListView.builder(
            itemCount: provider.contacts.length,
            itemBuilder: (context, index) {
              final contact = provider.contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        contact.nom.substring(0, 1).toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        contact.prenom.substring(0, 1).toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                title: Row(
                  children: [
                    Text(contact.nom, style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(contact.prenom, style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                subtitle: Text(contact.numero),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => ContactDialog(contact: contact),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.deleteContact(contact.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        tooltip: "ajouter un contact",
        child: Icon(Icons.add, color: Colors.blue, size: 40,),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => ContactDialog(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
