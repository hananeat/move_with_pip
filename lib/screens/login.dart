import 'package:flutter/material.dart';

// Importiamo la homepage perché dopo il login ci andremo
import 'homepage.dart';

// Import di lottie che abbiamo usato per l'animazione del pulcino. 
import 'package:lottie/lottie.dart';

// StatefulWidget perché la pagina deve "reagire" 
// quando l'utente scrive nei campi o preme il bottone
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Controllers: "ascoltano" cosa scrive l'utente nei campi
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Questa variabile controlla se la password è visibile o nascosta
  bool _isPasswordVisible = false;

  // I colori principali della nostra login page
  static const Color primaryPurple = Color(0xFF5D59B5); // viola principale
  static const Color bgLight = Color(0xFFEEF0FA);       // sfondo viola chiarissimo
  static const Color textDark = Color(0xFF2A2859);       // testo scuro
  static const Color textLight = Color(0xFF8684C6);      // testo secondario
  // Come nella splash screen, dispose() libera la memoria
  // quando l'utente lascia questa schermata
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Funzione chiamata quando l'utente preme "Login"
  void _handleLogin() {
    // Per ora navighiamo subito alla homepage.
    // In futuro qui ci andrà il controllo email/password
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight, // sfondo giallo chiarissimo
      body: SafeArea(
        // SafeArea evita che il contenuto finisca sotto
        // la "frangetta" o la barra in basso dell'iPhone
        child: SingleChildScrollView(
          // SingleChildScrollView permette di scorrere
          // quando la tastiera si apre e "spinge su" i widget
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 60),

              // --- LOGO / PULCINO ---
              // Usiamo la stessa animazione lottie della splash screen
              // width e height più piccoli perché è solo un logo
              Lottie.asset(
                  'assets/hatching_chick.json',
                width: 100,
                height: 100,
              ),

              const SizedBox(height: 16),

              // --- NOME APP ---
              const Text(
                'TwiC',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                  fontFamily: 'serif',
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'MOVE YOUR BODY,\n'
                'CALM YOUR MIND,\n'
                'Take care of yourself\n'
                'and your chick with TwiC!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 48),

              // --- CAMPO EMAIL ---
              // TextField è il widget di Flutter per i campi di testo
              TextField(
                controller: _emailController, // collegato al controller
                keyboardType: TextInputType.emailAddress, // tastiera con la @
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.email_outlined, 
                    color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    // focusedBorder = bordo quando il campo è selezionato
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: primaryPurple, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // --- CAMPO PASSWORD ---
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, 
                // obscureText: true = mostra i pallini ••••
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock_outlined, 
                    color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: primaryPurple, width: 2),
                  ),
                  // suffixIcon = icona a DESTRA del campo
                  // permette di mostrare/nascondere la password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // setState dice a Flutter di ridisegnare
                      // il widget con il nuovo valore
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // --- BOTTONE LOGIN ---
              SizedBox(
                width: double.infinity, // larghezza massima
                height: 55,
                child: ElevatedButton(
                  onPressed: _handleLogin, // chiama _handleLogin al tap
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPurple, // sfondo viola
                    foregroundColor: Colors.white, // testo bianco
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Accedi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- TESTO SOTTO IL BOTTONE ---
              // Per ora è solo estetico, in futuro può
              // portare a una schermata di registrazione
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Non hai un account? ',
                    style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigare alla schermata di registrazione
                    },
                    child: const Text(
                      'Registrati',
                      style: TextStyle(
                        color: primaryPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}