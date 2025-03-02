import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api_Service/Contacts_Api_Service.dart';
import '../models/contacts.dart';

class ContactProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Contact> _contacts = [];
  List<Contact> _allContacts = [];
  List<Contact> get contacts => _contacts;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
// Ajoute la méthode pour filtrer les contacts par groupe
  void filterContacts(int groupId) {
    // Si "Tous" est sélectionné (groupId == 0), on réaffiche tous les contacts
    if (groupId == 0) {
      _contacts = _allContacts;
    } else {
      // Sinon, on filtre les contacts par groupe
      _contacts = _allContacts.where((contact) => contact.groupeId == groupId).toList();
    }
    notifyListeners();
  }
  Future<void> fetchContacts() async {
    String? token = await _getToken();  // Récupère le token
    if (token != null) {
      _allContacts = await _apiService.fetchContacts(token); // Passe le token
      _contacts = _allContacts;
      notifyListeners();
    } else {
      throw Exception("Token non trouvé. L'utilisateur doit être connecté.");
    }
  }

  Future<void> addContact(Contact contact) async {
    String? token = await _getToken();
    if(token != null) {
      Contact newContact = await _apiService.addContact(contact, token);
      _contacts.add(newContact);
      _allContacts.add(newContact);
      notifyListeners();
    }else{
      throw Exception("Token non trouvé. L'utilisateur doit être connecté.");
    }
  }

  Future<void> updateContact(int id, Contact contact) async {
    String? token = await _getToken();
    if(token != null) {
      await _apiService.updateContact(id, contact, token);
      _contacts = _contacts.map((c) => c.id == id ? contact : c).toList();
      _allContacts = _allContacts.map((c) => c.id == id ? contact : c).toList(); // Mets à jour la liste complète aussi


      notifyListeners();
    }else{
      throw Exception("Token non trouvé. L'utilisateur doit être connecté.");
    }
  }

  Future<void> deleteContact(int id) async {
    String? token = await _getToken();
    if(token!=null) {
      await _apiService.deleteContact(id, token);
      _contacts.removeWhere((c) => c.id == id);
      _allContacts.removeWhere((c) => c.id == id);  // Supprime aussi de la liste complète
      notifyListeners();
    }
  }
}
