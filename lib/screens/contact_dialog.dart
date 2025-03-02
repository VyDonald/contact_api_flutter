import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/Contacts_Provider.dart';
import '../models/contacts.dart';

class ContactDialog extends StatefulWidget {
  final Contact? contact;

  ContactDialog({this.contact});

  @override
  _ContactDialogState createState() => _ContactDialogState();
}
class _ContactDialogState extends State<ContactDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _numeroController;
  late TextEditingController _prenomController;
  int _selectedGroupe = 1;
  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.contact?.nom ?? '');
    _numeroController = TextEditingController(text: widget.contact?.numero ?? '');
    _prenomController = TextEditingController(text: widget.contact?.prenom ?? '');
    _selectedGroupe = widget.contact?.groupeId ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.contact == null ? "Ajouter un contact" : "Modifier le contact",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: "Nom"),
                validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
              ),
              TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(labelText: "Prénom"),
                validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
              ),
              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(labelText: "Numéro"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<int>(
                value: _selectedGroupe,
                items: [
                  DropdownMenuItem(value: 1, child: Text("Amis")),
                  DropdownMenuItem(value: 2, child: Text("Famille")),
                  DropdownMenuItem(value: 3, child: Text("Travail")),
                  DropdownMenuItem(value: 4, child: Text("Camarade")),
                  DropdownMenuItem(value: 5, child: Text("Connaissance")),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedGroupe = value!;
                  });
                },
                decoration: InputDecoration(labelText: "Groupe"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Annuler"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newContact = Contact(
                          id: widget.contact?.id,
                          nom: _nomController.text,
                          prenom: _prenomController.text,
                          numero: _numeroController.text,
                          groupeId: _selectedGroupe,
                        );

                        final provider = Provider.of<ContactProvider>(context, listen: false);
                        if (widget.contact == null) {
                          provider.addContact(newContact);
                        } else {
                          provider.updateContact(widget.contact!.id!, newContact);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Valider"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
