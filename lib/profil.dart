import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'yerler.dart'; // yerler.dart dosyasını içeri aktarıyoruz
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gezveogren/profil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'profilyedek.dart';
import 'yerler.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'dart:convert';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geocoding/geocoding.dart' as geocoding hide Location;
import 'package:geocoding/geocoding.dart' as geocoding show locationFromAddress;

import 'package:firebase_core/firebase_core.dart'; // Firebase.initializeApp() için gerekli import


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'yerler.dart'; // yerler.dart dosyasını içeri aktarıyoruz

class Profilekrani extends StatefulWidget {
  @override
  _ProfilekraniState createState() => _ProfilekraniState();
}

class _ProfilekraniState extends State<Profilekrani>
    with SingleTickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();
  List<int> visitedPlaces = []; // Kaydedilmiş yerlerin listesi
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loadSelection();

    // Shake animasyonu için controller ve animation oluşturuluyor
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Animasyonun bir kere oynatılması ve tersine çevrilmesi
    _controller.forward().then((_) => _controller.reverse().then((_) => _controller.dispose()));
  }




  // Kaydedilmiş yerleri yükleyen fonksiyon
  Future<void> _loadSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      visitedPlaces = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary( // RepaintBoundary burada kullanılıyor
        key: _globalKey,
        child: PageView.builder(
          itemCount: visitedPlaces.length,
          itemBuilder: (context, index) {
            return _buildProfileCard(visitedPlaces[index]);

          },
        ),
      ),
    );
  }

  Widget _buildProfileCard(int placeId) {
    Yer yer = yerlerListesi.firstWhere((yer) => yer.id == placeId);
    return GestureDetector(

      onTap: () {
        _controller.forward(from: 0); // Tıklamada animasyonu başlat
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_animation.value, 0), // X ekseninde sallama
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white, // Beyaz arka plan rengi
                boxShadow: [ // Kartın hafif gölgesi
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          yer.gorselUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0), // Metinler arasındaki boşluk
                        child: Text(
                          yer.baslik,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24, // Başlık metni büyütüldü
                            color: Colors.black87, // Başlık metni rengi
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          yer.aciklama,
                          style: TextStyle(fontSize: 16, color: Colors.black54), // Açıklama metni rengi ve boyutu
                        ),
                      ),
                      SizedBox(height: 8), // Açıklama metni ile ID arasındaki boşluk
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blueAccent, size: 20), // Konum ikonu
                            SizedBox(width: 4), // İkon ile metin arasındaki boşluk
                            Text(
                              'Konum: ${yer.sehir}',
                              style: TextStyle(fontSize: 14, color: Colors.black87), // ID metni rengi ve boyutu
                            ),


                          ],
                        ),

                      ),

                      // yol tarifi kısmı

                      Padding(
                        padding: const EdgeInsets.all(12.0), // Metinler arasındaki boşluk
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.directions),
                                SizedBox(width: 8),
                                Text("Yol Tarifi"),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            String mapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=${yer.latitude},${yer.longitude}';
                            launch(mapsUrl);
                          },
                        ),
                      ),



                    ],
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removePlace(yer.id);
                        setState(() {
                          // Yerleri yeniden yükle
                          visitedPlaces.remove(yer.id);
                        });
                      },
                    ),
                  ),

                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Row(
                      children: [
                        Text(
                          "Galeriye kaydet",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),

                        ),
                        SizedBox(width: 8), // İkon ile metin arasındaki boşluk
                        IconButton(
                          onPressed: () {
                            _takeScreenshotAndSave();
                          },
                          icon: Icon(Icons.save, color: Colors.lightGreen),
                        ),


                      ],
                    )

                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Kaldırma işlemini gerçekleştiren fonksiyon
  void _removePlace(int placeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? visitedPlaces = prefs.getStringList('visited_places');

    if (visitedPlaces != null) {
      visitedPlaces.remove(placeId.toString());
      await prefs.setStringList('visited_places', visitedPlaces);

      setState(() {
        visitedPlaces = visitedPlaces;
      });
    }
  }


  // Ekran görüntüsü al ve galeriye kaydet
  void _takeScreenshotAndSave() async {
    try {
      RenderRepaintBoundary? boundary =
      _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        print('RenderRepaintBoundary is null.');
        return;
      }

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        print('ByteData is null.');
        return;
      }

      Uint8List imageData = byteData.buffer.asUint8List();
      var result = await ImageGallerySaver.saveImage(imageData);

      if (result != null && result['isSuccess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ekran görüntüsü galeriye kaydedildi.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ekran görüntüsünü galeriye kaydetme başarısız oldu.'),
          ),
        );
      }
    } catch (e) {
      print('Ekran görüntüsü alma hatası: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Animasyon controller'ı temizleniyor
    super.dispose();
  }
}












/* güzel fakat daha farklı şeyler eklemeli
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'yerler.dart'; // yerler.dart dosyasını içeri aktarıyoruz

class Profilekrani extends StatefulWidget {
  @override
  _ProfilekraniState createState() => _ProfilekraniState();
}

class _ProfilekraniState extends State<Profilekrani>
    with SingleTickerProviderStateMixin {
  List<int> visitedPlaces = []; // Kaydedilmiş yerlerin listesi
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _loadSelection();

    // Shake animasyonu için controller ve animation oluşturuluyor
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true); // Animasyonun tekrarlanması sağlanıyor
  }

  // Kaydedilmiş yerleri yükleyen fonksiyon
  Future<void> _loadSelection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      visitedPlaces = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: visitedPlaces.length,
        itemBuilder: (context, index) {
          return _buildProfileCard(visitedPlaces[index]);
        },
      ),
    );
  }

  Widget _buildProfileCard(int placeId) {
    Yer yer = yerlerListesi.firstWhere((yer) => yer.id == placeId);
    return GestureDetector(
      onTap: () {
        _controller.forward(from: 0); // Tıklamada animasyonu başlat
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_animation.value, 0), // X ekseninde sallama
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white, // Beyaz arka plan rengi
                boxShadow: [ // Kartın hafif gölgesi
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          yer.gorselUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0), // Metinler arasındaki boşluk
                        child: Text(
                          yer.baslik,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24, // Başlık metni büyütüldü
                            color: Colors.black87, // Başlık metni rengi
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          yer.aciklama,
                          style: TextStyle(fontSize: 16, color: Colors.black54), // Açıklama metni rengi ve boyutu
                        ),
                      ),
                      SizedBox(height: 8), // Açıklama metni ile ID arasındaki boşluk
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blueAccent, size: 20), // Konum ikonu
                            SizedBox(width: 4), // İkon ile metin arasındaki boşluk
                            Text(
                              'Konum: ${yer.sehir}',
                              style: TextStyle(fontSize: 14, color: Colors.black87), // ID metni rengi ve boyutu
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removePlace(yer.id);
                        setState(() {
                          // Yerleri yeniden yükle
                          visitedPlaces.remove(yer.id);
                        });
                      },
                    ),
                  ),

                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: IconButton(
                      icon: Icon(Icons.save, color: Colors.lightGreen),
                      onPressed: () {
                        // Galeriye kaydetme işlemi
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Kaldırma işlemini gerçekleştiren fonksiyon
  void _removePlace(int placeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? visitedPlaces = prefs.getStringList('visited_places');

    if (visitedPlaces != null) {
      visitedPlaces.remove(placeId.toString());
      await prefs.setStringList('visited_places', visitedPlaces);

      setState(() {
        visitedPlaces = visitedPlaces;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Animasyon controller'ı temizleniyor
    super.dispose();
  }
}



*/