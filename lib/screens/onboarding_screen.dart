import 'package:flutter/material.dart';
import 'package:speech_balloon/speech_balloon.dart';
import 'package:lottie/lottie.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routename = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Variables for the splash screen
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Controller for the name text field
  final TextEditingController _nameController = TextEditingController();
  String _chickName = 'Pip'; // default name

  // Colors taken from the design
  static const Color primaryPurple = Color(0xFF5D59B5);
  static const Color bgLight = Color(0xFFEEF0FA);
  static const Color textDark = Color(0xFF2A2859);
  static const Color textLight = Color(0xFF8684C6); // secondary text

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Go to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: ((context) =>  HomePage())),
      );
    }
  }

  // Build the dots for the page indicator
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: _currentPage == index ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? primaryPurple : primaryPurple.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // To avoid errors when the keyboard opens
      backgroundColor: bgLight,
      body: Stack(
        children: [
          // Assicura che tutto quello che c'è al suo interno venga disegnato lontano 
          //dal "Notch" o oltre la barra in basso degli iPhone, per evitare che i tuoi testi siano coperti dalle icone del telefono.
          SafeArea( 
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildPage1(),
                      _buildPage2(),
                      _buildPage3(),
                    ],
                  ),
                ),
                // Indicatori di pagina in basso
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => _buildDot(index)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- PAGINA 1 ---
  Widget _buildPage1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animazione 
          Lottie.asset(
            'assets/hatching_chick.json',
            width: 200,
            height: 200,   
          ),
          const SizedBox(height: 16),
          const Text(
            'Start this beautiful\njourney\nwith us',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              color: textDark,
              fontFamily: 'serif', // Stile elegante simile all'immagine
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Every step, every night of sleep,\nevery smile...it all counts.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textLight,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          _buildButton('Begin the journey!'),
        ],
      ),
    );
  }

  // --- PAGINA 2 ---
  Widget _buildPage2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryPurple.withOpacity(0.3)),
            ),
            child: const Text(
              "Hi! What's my name?",
              style: TextStyle(color: primaryPurple),
            ),
          ),

          const SizedBox(height: 16),

          // Placeholder del pulcino che esce dall'uovo
          Stack(
            alignment: Alignment.center,
            children: [
               Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFD158),
                ),
              ),
              const Icon(Icons.egg, color: Colors.white, size: 80),
            ],
          ),

          const SizedBox(height: 25),
          const Text(
            'MEET YOUR CHICK',
            style: TextStyle(
              color: primaryPurple,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Give it a name!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              color: textDark,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "It'll be by your side every day.\nChoose wisely!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textLight,
              fontSize: 16,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          
          // Griglia dei nomi suggeriti
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12.0,
            runSpacing: 12.0,
            children: ['Pip', 'Sol', 'Brio', 'Luna', 'Fil'].map((name) {
              final isSelected = _chickName == name;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _chickName = name;
                    _nameController.clear();
                    // Nascondiamo tastiera se era aperta
                    FocusScope.of(context).unfocus(); 
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryPurple.withOpacity(0.3) : primaryPurple.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: textDark,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          // Testo Libero per nome
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: primaryPurple.withOpacity(0.3), width: 1.5),
            ),
            child: TextField(
              controller: _nameController,
              textAlign: TextAlign.center,
              onChanged: (val) {
                if (val.isNotEmpty) {
                  setState(() {
                    _chickName = val;
                  });
                } else {
                  setState(() {
                    _chickName = 'Pip'; // default fallback se si svuota il campo
                  });
                }
              },
              style: const TextStyle(color: primaryPurple, fontSize: 18),
              decoration: InputDecoration(
                hintText: 'or type your own...',
                hintStyle: TextStyle(color: primaryPurple.withOpacity(0.5), fontSize: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Pulsante sfumato per confermare o disabilitato visualmente
          Opacity(
            opacity: _currentPage == 1 ? 1.0 : 0.5,
            child: _buildButton("That's the name!", isLight: true),
          ),
        ],
      ),
    );
  }

  // --- PAGINA 3 ---
  Widget _buildPage3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpeechBalloon(
            nipLocation: NipLocation.bottom,
            color: Colors.white,
            borderColor: primaryPurple,
            borderWidth: 3,
            borderRadius: 30,
            height: 80,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
              "Hi! I'm $_chickName,\nnice to meet you!",
              style: const TextStyle(color: primaryPurple),
              ),
            ),
          ),

          const SizedBox(height: 20),
         
          Lottie.asset(
            'assets/hatching_chick.json',
            width: 150,
            height: 150,),

          const SizedBox(height:10),
         
          const Text(
            'WELCOME',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 239, 176, 3),
              fontFamily: 'serif',
            ),
          ),

          const SizedBox(height: 24),
          Text(
            "$_chickName can't wait\nto grow alongside you!",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textLight,
              fontSize: 16,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 48),
          _buildButton("Let's get started!"),
        ],
      ),
    );
  }

  // --- PULSANTE GENERICO ---
  Widget _buildButton(String text, {bool isLight = false}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: isLight ? primaryPurple.withOpacity(0.4) : primaryPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: _nextPage,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isLight ? Colors.white : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
} //SplashScreen