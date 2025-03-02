import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "http://10.0.2.2:8000/api"; // Adapter selon ton environnement

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200 ) {
      final data = jsonDecode(response.body);
      await _saveToken(data['token']);
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password, // Laravel demande confirmation
        }),
      );

      print("Statut HTTP : ${response.statusCode}");  // ✅ Ajout pour voir le code retour
      print("Réponse API : ${response.body}"); // 🔥 Debugging

      if (response.statusCode == 201|| response.statusCode == 200) {
        return true;
      } else {
        print("Erreur API : ${response.body}"); // 🔥 Debugging
        return false;
      }
    } catch (e) {
      print("Erreur lors de la requête : $e"); // 🔥 Debugging
      return false;
    }
  }

  Future<void> logout() async {
    final token = await _getToken();
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    await _removeToken();
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
