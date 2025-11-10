import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função para lidar com o processo de login
  Future<void> _login() async {

    try {
      // Tenta fazer login com email e senha
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // Mostra um erro para o usuário se o login falhar
      final snackBar = SnackBar(
        content: Text('Erro: ${e.message}'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Página de Login", textScaler: TextScaler.linear(2),),
              SizedBox(height: 40,),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_sharp),
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox( height: 10,),
            //            Row(
            //              mainAxisAlignment: MainAxisAlignment.center,
            //              crossAxisAlignment: CrossAxisAlignment.center,
            //              children: [
            //                SizedBox(
            //                  width: 420, 
            //                  child: Align(
            //                  alignment: Alignment.centerLeft,
            //                  child: 
            //                  TextButton(
            //                  onPressed: (){
            //                      // Não existe sign in
            //                  }, 
            //                  child: Text(
            //                    "Sign in", 
            //                    style: TextStyle(color: Colors.lightBlue),
            //                    )
            //                  ),
            //                ),
            //                  ),
            //              ],
            //            ),
            //            SizedBox( height: 20,),
              SizedBox(
                height: 40, width: 200,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder()
                  ),
                  child: Text("Fazer login")),
              ),
            ],
                    ),
          ),
          Positioned(
      bottom: 5,
      right: 5,
      child: TextButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: "hyg0rbcp@gmail.com"));
        },
        child: const Text(
          "Em caso de problemas clique para copiar o e-mail de contato",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ),
        ]
      )
    );
  }
}