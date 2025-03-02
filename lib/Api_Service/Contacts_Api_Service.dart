import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contacts.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000/api"; // Pour l'émulateur Android

  Future<List<Contact>> fetchContacts(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/contacts"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("Statut HTTP : ${response.statusCode}");
      print("Réponse API : ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Vérifie si la réponse est une liste directement
        if (responseData is List) {
          List<Contact> contacts = responseData
              .map((json) => Contact.fromJson(json))
              .toList();
          return contacts;
        } else {
          throw Exception("Format de réponse incorrect, attendu une liste.");
        }
      } else {
        throw Exception("Erreur API : ${response.body}");
      }
    } catch (e) {
      print("❌ Erreur lors du chargement des contacts : $e");
      throw Exception("Erreur lors du chargement des contacts");
    }
  }



  Future<Contact> addContact(Contact contact, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      body: jsonEncode(contact.toJson()),
    );

    if (response.statusCode == 201) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erreur lors de l'ajout du contact");
    }
  }

  Future<void> updateContact(int id, Contact contact, String token) async {
    await http.put(
      Uri.parse('$baseUrl/contacts/$id'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(contact.toJson()),
    );
  }

  Future<void> deleteContact(int id, String token) async {
    await http.delete(Uri.parse('$baseUrl/contacts/$id'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
  }
}
