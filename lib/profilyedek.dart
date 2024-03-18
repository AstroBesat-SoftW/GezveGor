import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackForm(),
      theme: ThemeData(
        primaryColor: Colors.blue, // Ana renk
        accentColor: Colors.blueAccent, // Vurgu rengi
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, // Düğme rengi
            elevation: 5, // Gölgelendirme
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent), // Kutu kenarlığı rengi
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent), // Odaklanmış kutu kenarlığı rengi
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Hata kutu kenarlığı rengi
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Odaklanmış hata kutu kenarlığı rengi
          ),
        ),
      ),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _message;
  bool _feedbackSent = false;

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Firebase Authentication kullanarak kayıt işlemi (isteğe bağlı)
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: "dummyPassword", // Geçici bir şifre
        );
        print('Gönderen kullanıcı ${userCredential.user!.email}');

        // Realtime Database'e geri bildirim bilgilerini ekleme
        DatabaseReference feedbackRef =
        FirebaseDatabase.instance.reference().child('geribildirim');
        feedbackRef.push().set({
          'email': _email,
          'message': _message,
          'sender': userCredential.user!.email,
        });

        print('Geri bildirim gönderildi!');
        setState(() {
          _feedbackSent = true;
        });
      } catch (e) {
        print('Error: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Geri bildirim gönderilmedi, bir hata oluştu.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geri Bildirim Formu'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.blue], // Arka plan renk geçişi
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFE4F3FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15), // Kutu kenarlarını yuvarla
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Gölgelendirme rengi ve opaklık
                        spreadRadius: 3, // Yayılma yarıçapı
                        blurRadius: 5, // Bulanıklık yarıçapı
                        offset: Offset(0, 3), // Gölgelendirme yönü (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email), // Ön ek icon
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'E-Postanızı giriniz';
                              }
                              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                  .hasMatch(value)) {
                                return 'Hatalı E-Posta girişi';
                              }
                              return null;
                            },
                            onSaved: (value) => _email = value!,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Mesaj',
                              prefixIcon: Icon(Icons.message), // Ön ek icon
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Mesaj yazınız';
                              }
                              return null;
                            },
                            onSaved: (value) => _message = value!,
                            maxLines: 5, // Birden fazla satıra izin ver
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: _feedbackSent ? null : _submitFeedback,
                              child: Text('Geri bildirimi gönder'),
                            ),
                          ),
                          SizedBox(height: 8), // Buton ile geri bildirim metni arasına boşluk ekler
                          Align(
                            alignment: Alignment.center,
                            child: _feedbackSent
                                ? Text('Geri bildirim gönderildi!')
                                : SizedBox(),
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: Image.asset(
                              'assets/bildirim.png', // Görselin yolunu belirt
                              height: 200, // Yükseklik
                              fit: BoxFit.contain, // Boyutlandırma modu
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}
