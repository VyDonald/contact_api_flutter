
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Providers/auth_provider.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _register() async {
    setState(() => _isLoading = true);
    bool success = await Provider.of<AuthProvider>(context, listen: false)
        .register(_nameController.text, _emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inscription réussie, connectez-vous !")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(), fullscreenDialog: true),
      );
    } else {
      print("Entré dans le bloc d'erreur");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de l'inscription")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return  Scaffold(
      backgroundColor: Colors.white24,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: screenheight*0.04),
                  child: Text("Créer un compte !",
                    style: GoogleFonts.simonetta(
                      fontSize: screenwidth*0.1,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                SizedBox(height: screenheight*0.07,),
                Container(
                  width: screenwidth*0.8,
                  height: screenheight*0.6,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(screenheight*0.02)
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: screenheight*0.01),
                        child: Text("Register",
                          style: TextStyle(
                            fontSize: screenwidth*0.06,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: screenheight*0.06,),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenwidth*0.04,
                                ),
                                controller:  _nameController,
                                decoration: InputDecoration(
                                  hintText: "Nom",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: screenheight*0.03,
                                    color: Colors.white70,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: screenheight*0.02,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre nom';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenheight*0.03,),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenwidth*0.05,
                                ),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    size: screenheight*0.03,
                                    color: Colors.white70,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: screenheight*0.02,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre mail';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenheight*0.03,),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenwidth*0.05,
                                ),
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.key,
                                    size: screenheight*0.03,
                                    color: Colors.white70,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: screenheight*0.02,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre mot de passe';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: screenheight*0.1,),
                              _isLoading
                              ?CircularProgressIndicator()
                              :ElevatedButton.icon(onPressed: () {
                              if (formKey.currentState!.validate()) {
                                _register();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content : Text("Inscription réussie !!!",),
                                  backgroundColor: Colors.lightGreen,
                                ),
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content : Text("Veuillez remplir tous les champs !!"),
                                  backgroundColor: Colors.red,
                                ),
                                );
                              }

                              },
                                label: Text("S'enregistrer",
                                  style: GoogleFonts.habibi(
                                    fontSize: screenwidth*0.05,
                                    color: Colors.black,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenwidth*0.04,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("      Already have a account ??", style: TextStyle(
                        fontSize: screenwidth*0.04,
                        color: Colors.white70
                    ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder:
                              (context)=>LoginScreen(),
                            fullscreenDialog: true,
                        ),
                        );
                      },
                      child: Text("Se connecter",
                        style: TextStyle(
                            fontSize: screenwidth*0.04,
                            color: Colors.blueAccent
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
