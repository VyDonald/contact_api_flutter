import 'package:contact_repertory/screens/contact_list.dart';
import 'package:contact_repertory/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);
    bool success = await Provider.of<AuthProvider>(context, listen: false)
        .login(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ContactListScreen(), fullscreenDialog: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec de connexion")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.white24,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: screenheight*0.01),

                  child: Text("Bienvenue!",
                    style: GoogleFonts.simonetta(
                      fontSize: screenwidth*0.1,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                SizedBox(height: screenheight*0.08,),
                Container(
                  width: screenwidth*0.8,
                  height: screenheight*0.5,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(screenheight*0.02)
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: screenheight*0.01),
                        child: Text("Se connecter",
                          style: TextStyle(
                            fontSize: screenwidth*0.06,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: screenheight*0.05,),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
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
                              SizedBox(height: screenheight*0.06,),
                              TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
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
                              :ElevatedButton.icon(onPressed: () async{
                                if (formKey.currentState!.validate()) {
                                  _login();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content : Text("Connection réussie !!!",),
                                      backgroundColor: Colors.lightGreen,
                                    ),
                                    );
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content : Text("Incorrecte password or email !!"),
                                      backgroundColor: Colors.red,
                                    ),
                                    );
                                  }
                                },
                                label: Text("Connection",
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
                    Text("      Don't have account ??", style: TextStyle(
                        fontSize: screenwidth*0.04,
                        color: Colors.white70
                    ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>RegisterScreen(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Text("S'Enregistrer !!",
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
