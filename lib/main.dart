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




import 'package:firebase_core/firebase_core.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  // DropdownButton için kullanılacak şehirler kümesi
  String selectedCity = 'Çanakkale';
  Set<String> uniqueCities = {'Tümünü Göster'};
  // yerlerListesi'nde bulunan şehirleri kümeye ekleyin
  //bool isAdded = false;  // seçildiğini anlamk için ekledim
  Map<String, Uint8List> imageCache = {};
  Set<Marker> markers = Set<Marker>();


  TextEditingController searchController = TextEditingController();


  int _currentIndex = 0; // Varsayılan olarak ilk seçenek seçili

  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Ana Sayfa',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Yakın Yerleri Göster',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Gezme Listem',
    ),
  ];

  //final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getLocation();
    _initImageCache();
    _populateUniqueCities();
  }

  Future<void> _initImageCache() async {
    await Future.forEach(yerlerListesi, (yer) async {
      try {
        final imageBytes = await getImageBytes(yer.gorselUrl);
        imageCache[yer.gorselUrl] = imageBytes;
      } catch (e) {
        print('Image download failed for ${yer.gorselUrl}: $e');
      }
    });
  }


  void _populateUniqueCities() {
    for (var yer in yerlerListesi) {
      uniqueCities.add(yer.sehir);
    }
  }
  Future<void> _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Konum servislerinin etkin olup olmadığını kontrol edin
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Konum izinlerini kontrol edin
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Konum verilerini alın
    _locationData = await location.getLocation();
    setState(() {
      currentLocation = _locationData;
      _updateCityFromLocation();
    });
  }

  void _updateCityFromLocation() async {
    if (currentLocation != null) {
      List<geocoding.Placemark> placemarks =
      await geocoding.placemarkFromCoordinates(
          currentLocation!.latitude!, currentLocation!.longitude!);

      if (placemarks.isNotEmpty) {
        String city = placemarks.first.locality ?? 'Unknown';
        setState(() {
          selectedCity = city;
        });
      }
    }
  }



  // ilk
  // en başta yaptım Map<String, Uint8List> imageCache = {};

  Future<Uint8List> getImageBytes(String imageUrl) async {
    if (imageCache.containsKey(imageUrl)) {
      return imageCache[imageUrl]!;
    }

    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final originalImage = img.decodeImage(response.bodyBytes);

      if (originalImage != null) {
        // Ekranın %8'ini kaplamak için yeni boyutları hesaplayın.
        final screenWidth = 1920; // Ekran genişliği varsayılan olarak 1920 olarak kabul ediliyor.
        final screenHeight = 1080; // Ekran yüksekliği varsayılan olarak 1080 olarak kabul ediliyor.
        final newWidth = (screenWidth * 0.10).toInt();
        final newHeight = (screenHeight * 0.10).toInt();

        // Görüntüyü yeniden boyutlandırın.
        final resizedImage = img.copyResize(originalImage, width: newWidth, height: newHeight);

        // Yeniden boyutlandırılmış görüntüyü Uint8List'e dönüştürün.
        final scaledBytes = Uint8List.fromList(img.encodePng(resizedImage));

        // Önbelleğe ekle
        imageCache[imageUrl] = scaledBytes;

        return scaledBytes;
      } else {
        throw Exception('Image decoding failed');
      }
    } else {
      throw Exception('Image download failed');
    }
  }

  // son

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(
      title: const Text('Gez ve gör'),
         flexibleSpace: Container(
          decoration: BoxDecoration(
             gradient: LinearGradient(
                begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
              colors: [Colors.blueGrey, Colors.blue], // Arka plan renk geçişi
                   ),
                   ),
                  ),
            // menü sağ  işlev için başilangıç

        actions: <Widget>[
    PopupMenuButton(
    itemBuilder: (BuildContext context) {
    return [
    PopupMenuItem(
    child: InkWell(
    onTap: () {

        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  FeedbackForm()),
      );
    },
    child: Text("Geri Bildirim Gönder"),
    ),
    ),
    ];
    }, ),
        ],
    
    
    
  


          // menü sağ işlev son


           ),
      body: Stack(
        children: [
          _buildBody(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: bottomNavigationBarItems,
        backgroundColor: Colors.transparent, // Arkaplan rengini şeffaf yap
        elevation: 0, // Gölgeyi kaldır
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue, // Seçilen öğenin rengi
        unselectedItemColor: Colors.blueGrey, // Seçilmemiş öğelerin rengi
        selectedFontSize: 14, // Seçilen öğenin yazı boyutu
        unselectedFontSize: 14, // Seçilmemiş öğelerin yazı boyutu
        showUnselectedLabels: true, // Seçilmemiş öğelerin etiketlerini göster
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), // Seçilen öğenin etiket stilleri
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal), // Seçilmemiş öğelerin etiket stilleri
      ),

    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return FutureBuilder<List<Marker>>(
          future: loadMarkers(selectedCity),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        currentLocation?.latitude ?? 37.7749,
                        currentLocation?.longitude ?? -122.4194,
                      ),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    markers: {
                      if (currentLocation != null)
                        Marker(
                          markerId: MarkerId('current_location'),
                          position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                          infoWindow: InfoWindow(title: 'Kendi Konumunuz'),
                        ),
                    }..addAll(Set<Marker>.from(snapshot.data!)),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 80,
                    right: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            _showCitySelectionDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                selectedCity,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        );
      case 1:
        return _buildSearchScreen();
      case 2:
        //return profilekrani();
          return Profilekrani();
      default:
        return Center(
          child: Text('Ana Sayfa Ekranı'),
        );
    }
  }


 /* Widget ilkekrannnnn() {
    switch (_currentIndex) {
      case 0:
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              currentLocation?.latitude ?? 37.7749,
              currentLocation?.longitude ?? -122.4194,
            ),
            zoom: 15.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          markers: markers,
        );
      case 1:
        return _buildSearchScreen();
      case 2:
        return Center(
          child: Text('Profil Ekranı'),
        );
      default:
        return Center(
          child: Text('Ana Sayfa Ekranı'),
        );
    }
  }
  */
  void _showCitySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Şehir Seç'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: uniqueCities.map((String city) {
                return ListTile(
                  title: Text(city),
                  onTap: () {
                    setState(() {
                      selectedCity = city;
                      _updateMarkers();
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  void _updateMarkers() {
    setState(() {
      markers.clear(); // Haritadaki mevcut marker'ları temizle
    });

    // Yeni seçilen şehire göre marker'ları yükle
    loadMarkers(selectedCity);
  }

  // bu kısım ilk açılan sayfada tıkladığında açılan ekran ve gezilecek yer ekleme kısmı

  Future<List<int>> getVisitedPlaces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> visitedPlaces = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];
    return visitedPlaces;
  }
  Future<void> addToVisitedPlaces(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> addedIds = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];

    if (!addedIds.contains(id)) {
      addedIds.add(id);
      await prefs.setStringList('visited_places', addedIds.map((e) => e.toString()).toList());
    }
  }

  Future<bool> isVisitedPlace(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> addedIds = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];
    return addedIds.contains(id);
  }

  Future<List<Marker>> loadMarkers(String selectedCity) async {
    List<Marker> newMarkers = [];
    bool isAdded = false; // _MapScreenState sınıfının içinde tanımlanan bir özellik
    await Future.forEach(yerlerListesi, (yer) async {
      if (selectedCity == 'Tümünü Göster' || yer.sehir == selectedCity) {
        final imageBytes = await getImageBytes(yer.gorselUrl);
        newMarkers.add(
          Marker(
            markerId: MarkerId(yer.baslik),
            position: LatLng(yer.latitude, yer.longitude),
            icon: BitmapDescriptor.fromBytes(imageBytes),
            infoWindow: InfoWindow(
              title: yer.baslik,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    yer.baslik,
                                    style: TextStyle(fontSize: 15),
                                  ), Text(
                                    ' - Gezme listene eklemek için ',
                                    style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                                  ),
                                  Icon(Icons.add_circle_outline),
                                  SizedBox(width: 4), // Metin ve simge arasında boşluk
                                  Text(
                                    ' Eklendi ise ',
                                    style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                                  ),
                                  Icon(Icons.check_circle, color: Colors.green),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Image.network(
                              yer.gorselUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            //Text("\n" + yer.aciklama),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:8.0), // Soldan ve sağdan 8 piksel uzaklık
                              child: Text(
                                "\n" + yer.aciklama,
                                // textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),

                            //Text("Gezme listene"),


                            const SizedBox(height: 1),
                            IconButton(
                              icon: FutureBuilder<bool>(
                                future: isVisitedPlace(yer.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Icon(Icons.add_circle_outline);
                                  } else {
                                    return snapshot.data ?? false
                                        ? Icon(Icons.check_circle, color: Colors.green)
                                        : Icon(Icons.add_circle_outline);

                                  }
                                },
                              ),
                              onPressed: () async {
                                bool isVisited = await isVisitedPlace(yer.id);
                                if (!isVisited) {
                                  await addToVisitedPlaces(yer.id);
                                  setState(() {
                                    isAdded = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Eklendi!'),
                                    ),
                                  );
                                }
                              },

                              tooltip: 'Gezme listesine ekle',
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder<List<int>>(
                              future: getVisitedPlaces(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Hata: ${snapshot.error}');
                                } else {
                                  final visitedPlaces = snapshot.data ?? [];
                                  return Text('');  //Text('Gezilen Yerler: ${visitedPlaces.join(', ')}');
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      }
    });

    return newMarkers;
  }
  /*
  // bu kısım ilk açılan sayfada tıkladığında açılan ekran ve gezilecek yer ekleme kısmı

  Future<List<int>> getVisitedPlaces() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> visitedPlaces = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];
    return visitedPlaces;
  }
  Future<void> addToVisitedPlaces(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> addedIds = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];

    if (!addedIds.contains(id)) {
      addedIds.add(id);
      await prefs.setStringList('visited_places', addedIds.map((e) => e.toString()).toList());
    }
  }

  Future<bool> isVisitedPlace(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> addedIds = prefs.getStringList('visited_places')?.map(int.parse)?.toList() ?? [];
    return addedIds.contains(id);
  }

  Future<List<Marker>> loadMarkers(String selectedCity) async {
    List<Marker> newMarkers = [];
    bool isAdded = false; // _MapScreenState sınıfının içinde tanımlanan bir özellik
    await Future.forEach(yerlerListesi, (yer) async {
      if (selectedCity == 'Tümünü Göster' || yer.sehir == selectedCity) {
        final imageBytes = await getImageBytes(yer.gorselUrl);
        newMarkers.add(
          Marker(
            markerId: MarkerId(yer.baslik),
            position: LatLng(yer.latitude, yer.longitude),
            icon: BitmapDescriptor.fromBytes(imageBytes),
            infoWindow: InfoWindow(
              title: yer.baslik,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(yer.baslik),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Image.network(
                              yer.gorselUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            Text("\n" + yer.aciklama + yer.id.toString()),
                            const SizedBox(height: 20),

                            IconButton(
                              icon: FutureBuilder<bool>(
                                future: isVisitedPlace(yer.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Icon(Icons.add_circle_outline);
                                  } else {
                                    return snapshot.data ?? false
                                        ? Icon(Icons.check_circle, color: Colors.green)
                                        : Icon(Icons.add_circle_outline);
                                  }
                                },
                              ),
                              onPressed: () async {
                                bool isVisited = await isVisitedPlace(yer.id);
                                if (!isVisited) {
                                  await addToVisitedPlaces(yer.id);
                                  setState(() {
                                    isAdded = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Eklendi!'),
                                    ),
                                  );
                                }
                              },

                              tooltip: 'Gezme listesine ekle',
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder<List<int>>(
                              future: getVisitedPlaces(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Hata: ${snapshot.error}');
                                } else {
                                  final visitedPlaces = snapshot.data ?? [];
                                  return Text('Gezilen Yerler: ${visitedPlaces.join(', ')}');
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      }
    });

    return newMarkers;
  }

   bu üstte iyi ekleme yapıyorum alta temel olarak text olarak ekranda yazdırıyorum ama güncelleme yapmam gerek
  bu sayede text değilde daha havalı şekilde yansıtmaloyım*/

  // arama özelliği eklenirse
  /*
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return FutureBuilder<List<Marker>>(
          // Replace this with your actual asynchronous data loading function
          future: loadMarkers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for data
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle error case
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Data is ready, build the GoogleMap widget
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        currentLocation?.latitude ?? 37.7749,
                        currentLocation?.longitude ?? -122.4194,
                      ),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    markers: {
                      if (currentLocation != null)
                        Marker(
                          markerId: MarkerId('current_location'),
                          position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                          infoWindow: InfoWindow(title: 'Kendi Konumunuz'),
                        ),
                    }..addAll(Set<Marker>.from(snapshot.data!)),
                  ),

                  /* bu eksi olan  kendi konumuda gösterme eklecem o yüzden saklıyorum
                    GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        currentLocation?.latitude ?? 37.7749,
                        currentLocation?.longitude ?? -122.4194,
                      ),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    markers: Set<Marker>.from(snapshot.data!),
                  ), */
                  _buildSearchBar(), // Ekranın üst kısmına arama çubuğunu ekler
                ],
              );
            }
          },
        );
      case 1:
        return _buildSearchScreen();
      case 2:
        return Center(
          child: Text('Profil Ekranı'),
        );
      default:
        return Center(
          child: Text('Ana Sayfa Ekranı'),
        );
    }
  }

   Widget _buildSearchBar() {
    return Positioned(
      top: 16.0,
      left: 16.0,
      right: 16.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextField(
          onChanged: (query) {
            // Handle search query changes
            _searchCity(query);
          },
          decoration: InputDecoration(
            hintText: 'Ara...',
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  Future<void> _searchCity(String cityName) async {
    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(cityName);

      if (locations.isNotEmpty) {
        geocoding.Location firstLocation = locations.first;

        // Update the map to focus on the searched location
        mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(firstLocation.latitude, firstLocation.longitude)),
        );
      } else {
        // Handle case when no location is found
        print('No location found for $cityName');
      }
    } catch (e) {
      // Handle exceptions
      print('Error during location search: $e');

      // Show a user-friendly message about the error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Hata'),
          content: Text('Şehir bulunamadı. Lütfen geçerli bir şehir adı girin.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

*/
// arama kısmıydı üstü


// bu alt kısım yakın yerler için:
  //YAKIN YERLER   =====

  //alt farklı orta ekran




  // bu şimdi ekleceğimde radians lar için

  double radians(double degrees) {
    return degrees * (pi / 180.0);
  }


  // Haversine formülü kullanarak iki nokta arasındaki mesafeyi hesaplayan bir işlev
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Yeryüzünün ortalama yarıçapı (km)

    final lat1Rad = radians(lat1);
    final lon1Rad = radians(lon1);
    final lat2Rad = radians(lat2);
    final lon2Rad = radians(lon2);

    final dlon = lon2Rad - lon1Rad;
    final dlat = lat2Rad - lat1Rad;

    final a = pow(sin(dlat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(dlon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = R * c; // Mesafe (km)
    return distance;
  }


  Widget _buildSearchScreen() {
    // Yerleri mesafeye göre sırala
    yerlerListesi.sort((a, b) {
      final distanceA = calculateDistance(
        currentLocation?.latitude ?? 0.0,
        currentLocation?.longitude ?? 0.0,
        a.latitude,
        a.longitude,
      );

      final distanceB = calculateDistance(
        currentLocation?.latitude ?? 0.0,
        currentLocation?.longitude ?? 0.0,
        b.latitude,
        b.longitude,
      );

      return distanceA.compareTo(distanceB);
    });

    // Sadece en yakın 10 yer göster
    final enYakinYerler = yerlerListesi.take(10).toList();

    return Container(
      color: Colors.white, // Arka plan rengi
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder<List<Marker>>(


              // Replace this with your actual asynchronous data loading function
              future: loadMarkers(selectedCity),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                } else {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        currentLocation?.latitude ?? 37.7749,
                        currentLocation?.longitude ?? -122.4194,
                      ),
                      zoom: 15.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    markers: Set<Marker>.from(asyncSnapshot.data!),
                  );
                }
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text("Konumunuza en yakın 10 bölge"),
          ),
          Expanded(
            child: ListView(
              children: enYakinYerler.map((yer) {
                final distance = calculateDistance(
                  currentLocation?.latitude ?? 0.0,
                  currentLocation?.longitude ?? 0.0,
                  yer.latitude,
                  yer.longitude,
                );
                return Container(
                  color: Colors.white, // Arka plan rengi
                  child: ListTile(
                    leading: Image.network(yer.gorselUrl, width: 50, height: 50),
                    title: Text(yer.baslik),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Konum: ' + yer.sehir),
                        Text(yer.aciklama),
                        Text('Uzaklık: ${distance.toStringAsFixed(2)} km'),
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              yer.baslik,
                                              style: TextStyle(fontSize: 16),
                                            ), Text(
                                              '  -  Gezme listene eklemek için ',
                                              style: TextStyle(fontSize: 9, fontStyle: FontStyle.italic),
                                            ),
                                            Icon(Icons.add_circle_outline),
                                            SizedBox(width: 4), // Metin ve simge arasında boşluk
                                            Text(
                                              ' Eklendi ise ',
                                              style: TextStyle(fontSize: 9, fontStyle: FontStyle.italic),
                                            ),
                                            Icon(Icons.check_circle, color: Colors.green),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),

                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: Image.network(
                                          yer.gorselUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ), SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),

                                        child: Text(yer.aciklama),
                                      ),



                                      const SizedBox(height: 16),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.directions),
                                            SizedBox(width: 8),
                                            Text("Yol Tarifi"),
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          String mapsUrl =
                                              'https://www.google.com/maps/dir/?api=1&destination=${yer.latitude},${yer.longitude}';
                                          launch(mapsUrl);
                                        },
                                      ),
                                      const SizedBox(height: 5),
                                      IconButton(
                                        icon: FutureBuilder<bool>(
                                          future: isVisitedPlace(yer.id),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Icon(Icons.add_circle_outline);
                                            } else {
                                              return snapshot.data ?? false
                                                  ? Icon(Icons.check_circle, color: Colors.green)
                                                  : Icon(Icons.add_circle_outline);

                                            }
                                          },
                                        ),
                                        onPressed: () async {
                                          bool isVisited = await isVisitedPlace(yer.id);
                                          if (!isVisited) {
                                            await addToVisitedPlaces(yer.id);
                                            setState(() {
                                              var  isAdded = true;
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Eklendi!'),
                                              ),
                                            );
                                          }
                                        },

                                        tooltip: 'Gezme listesine ekle',
                                      ),


                                      const SizedBox(height: 16),
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(yer.latitude, yer.longitude),
                                            zoom: 15.0,
                                          ),
                                          markers: Set<Marker>.from([
                                            Marker(
                                              markerId: MarkerId('yer'),
                                              position: LatLng(yer.latitude, yer.longitude),
                                              infoWindow: InfoWindow(title: yer.baslik),
                                            ),
                                          ]),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  ///////////// profil ekranı menü 3


  Widget profilekrani() {
    switch (_currentIndex) {
      case 0:
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              currentLocation?.latitude ?? 37.7749,
              currentLocation?.longitude ?? -122.4194,
            ),
            zoom: 15.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          markers: markers,
        );
      case 1:
        return _buildSearchScreen();
      case 2:
        //return Center(
         // child: Text('Profil Ekranı Besat - V1.36'),
        //);
        return Profilekrani();
      default:
        return Center(
          child: Text('Ana Sayfa Ekranı'),
        );
    }
  }




  /* bir eski sıralama ilkten alarak yapan
  Widget _buildSearchScreen() {

    return Container(
      color: Colors.white, // Arka plan rengi

      child: Column(

      children: [
        Container(

          height: MediaQuery.of(context).size.height * 0.3,
          child: FutureBuilder<List<Marker>>(
            // Replace this with your actual asynchronous data loading function
            future: loadMarkers2(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (asyncSnapshot.hasError) {
                return Center(child: Text('Error: ${asyncSnapshot.error}'));
              } else {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation?.latitude ?? 37.7749,
                      currentLocation?.longitude ?? -122.4194,
                    ),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  markers: Set<Marker>.from(asyncSnapshot.data!),
                );
              }
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Text("Konumunuza en yakın 10 bölge"),

        ),

        Expanded(

          child: ListView(
            children: (yerlerListesi ?? []).take(20).map((yer) {
              final distance = calculateDistance(
                currentLocation?.latitude ?? 0.0,
                currentLocation?.longitude ?? 0.0,
                yer.latitude,
                yer.longitude,
              );
              return Container(
                  color: Colors.white, // Arka plan rengi
                  child: ListTile(

                leading: Image.network(yer.gorselUrl, width: 50, height: 50),
                title: Text(yer.baslik),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Konum: ' + yer.sehir), // duruma göre silerim sonra ekledim sahte çoğu şuan
                    Text(yer.aciklama),

                    Text('Uzaklık: ${distance.toStringAsFixed(2)} km'),
                  ],
                ),
                onTap: () {
                  // Yere tıklandığında ilgili işlemleri yapabilirsiniz.

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(

                              decoration: BoxDecoration(
                                color: Colors.white, // Arka plan rengi transparan (saydam)

                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.0), // Üst kenarları ovallimsi yapar
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    //color: Colors.grey, // Gölgelendirme rengi
                                    //offset: Offset(0, -2), // Gölgelendirme yüksekliği
                                    //blurRadius: 6.0, // Gölgelendirme belirginliği
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(yer.baslik),
                                    onTap: () {
                                      // Burada ilgili konumun detay sayfasına yönlendirebilirsiniz
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: Image.network(
                                      yer.gorselUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(yer.aciklama),
                                  ),
                                  const SizedBox(height: 16), // Yatay boşluk ekleyin
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.directions),
                                        SizedBox(width: 8), // İkon ile metin arasına boşluk ekleyin
                                        Text("Yol Tarifi"),
                                      ],
                                    ),
                                    onTap: () {
                                      // Yol tarifi işlemi burada gerçekleştirilebilir
                                      // Örneğin, Google Maps URL'sine yönlendirme yapabilirsiniz
                                      Navigator.pop(context); // Alt sayfayı kapat
                                      // Yol tarifi için Google Maps URL'sini oluşturun
                                      String mapsUrl =
                                          'https://www.google.com/maps/dir/?api=1&destination=${yer.latitude},${yer.longitude}';
                                      // URL'yi açmak için bir paket kullanın (örneğin url_launcher)
                                      // Bu örnek url_launcher paketini kullanır
                                      launch(mapsUrl);
                                    },
                                  ),
                                  const SizedBox(height: 16), // Yatay boşluk ekleyin
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(yer.latitude, yer.longitude),
                                        zoom: 15.0,
                                      ),
                                      markers: Set<Marker>.from([
                                        Marker(
                                          markerId: MarkerId('yer'),
                                          position: LatLng(yer.latitude, yer.longitude),
                                          infoWindow: InfoWindow(title: yer.baslik),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );


                  // dokunma olayı son
                },

              ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
    );

  }

  */






  // YAKIN YERLER SON =====
}


/* son yedek
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gezveogren/yakinbolge.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'yerler.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

void main() => runApp(MyApp(yerlerListesi: yerlerListesi));

class MyApp extends StatelessWidget {
  final List<Yer> yerlerListesi;



  MyApp({required this.yerlerListesi});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(yerlerListesi: yerlerListesi),
    );
  }
}

class MapScreen extends StatefulWidget {
  final List<Yer> yerlerListesi;


  MapScreen({required this.yerlerListesi});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    // Konum verilerini almak için kullanılan kod
    // (Daha önceki kodu kullanabilirsiniz)
  }

  // gorslı alma işlemleri urlden
  Future<Uint8List> getImageBytes(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final originalImage = img.decodeImage(response.bodyBytes);
      final screenWidth = 1920; // Ekran genişliği varsayılan olarak 1920 olarak kabul ediliyor.
      final screenHeight = 1080; // Ekran yüksekliği varsayılan olarak 1080 olarak kabul ediliyor.

      if (originalImage != null) {
        // Ekranın %8'ini kaplamak için yeni boyutları hesaplayın.
        final newWidth = (screenWidth * 0.10).toInt();
        final newHeight = (screenHeight * 0.10).toInt();

        // Görüntüyü yeniden boyutlandırın.
        final resizedImage = img.copyResize(originalImage, width: newWidth, height: newHeight);

        // Yeniden boyutlandırılmış görüntüyü Uint8List'e dönüştürün.
        final resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

        return resizedBytes;
      } else {
        throw Exception('Image decoding failed');
      }
    } else {
      throw Exception('Image download failed');
    }
  }
  // alt menü için
  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Ana Sayfa',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Ara',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  int _currentIndex = 0; // Varsayılan olarak ilk seçenek seçili

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gez ve gör || Kültürel Şok'),
      ),
      body: FutureBuilder<List<Marker>>(
        // Replace this with your actual asynchronous data loading function
        future: loadMarkers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for data
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error case
            return Text('Error: ${snapshot.error}');
          } else {
            // Data is ready, build the GoogleMap widget
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation?.latitude ?? 37.7749,
                      currentLocation?.longitude ?? -122.4194,
                    ),
                    zoom: 15.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  markers: Set<Marker>.from(snapshot.data as Iterable),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // İlgili alt menü seçeneğine göre işlemleri burada yapabilirsiniz
          if (_currentIndex == 0) {
            // İlk seçenek seçildiğinde yapılacak işlemler
          } else if (_currentIndex == 1) {
            // İkinci seçenek seçildiğinde yapılacak işlemler

          @override
          Widget build(BuildContext context) {
          return Scaffold(
          appBar: AppBar(
          title: Text('Yakın Bölgeler'),
          ),
          body: Center(
          child: Text('Hoşgeldin'),
          ),
          );
          }




          } else if (_currentIndex == 2) {
            // Üçüncü seçenek seçildiğinde yapılacak işlemler
          }
        },
        items: bottomNavigationBarItems,
      ),
    );
  }


  Future<List<Marker>> loadMarkers() async {
    // Replace this with your actual marker loading logic
    List<Marker> markers = [];

    for (var yer in widget.yerlerListesi) {
      final imageBytes = await getImageBytes(yer.gorselUrl);
      markers.add(
        Marker(
          markerId: MarkerId(yer.baslik),
          position: LatLng(yer.latitude, yer.longitude),
          icon: BitmapDescriptor.fromBytes(imageBytes),
          infoWindow: InfoWindow(
            title: yer.baslik,
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(yer.baslik),
                      onTap: () {
                        // Burada ilgili konumun detay sayfasına yönlendirebilirsiniz
                        Navigator.pop(context);
                      },
                    ),
                    Image.network(
                      yer.gorselUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Text("\n" + yer.aciklama),
                    const Text(" \n\n\n"),
                  ],
                );
              },
            );



          },
        ),
      );
    }

    return markers;
  }
}


*/
/*
bu güzel fakat konum üstüne tıklayınca sabit veriyor

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final String apiKey = 'AIzaSyAqoYtOZPlJ48ubFAMKi55DJNVexkc3b3U'; // Google Maps API anahtarınızı buraya ekleyin
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // Konum verilerini almak için kullanılan fonksiyon
  Future<void> _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    // Konum servislerinin etkin olup olmadığını kontrol edin
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Konum izinlerini kontrol edin
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Konum verilerini alın
    _locationData = await location.getLocation();
    setState(() {
      currentLocation = _locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gez ve gör || Kültürel Şok'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation?.latitude ?? 37.7749,
            currentLocation?.longitude ?? -122.4194,
          ),
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId('marker_1'),
            position: LatLng(
              currentLocation?.latitude ?? 37.7749,
              currentLocation?.longitude ?? -122.4194,
            ),
            infoWindow: InfoWindow(title: 'Konumunuz'),
            onTap: () {
              // Burada konuma tıklandığında yapılacak işlemleri ekleyebilirsiniz.
              // Örneğin, konumun bilgilerini gösteren bir ekranı açabilirsiniz.
              _showLocationInfo(context, "Çanakkale Kalesi", "Çanakkale Kalesi açıklaması",
                  "https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20180319134434287_KILITBAHIR.jpg?format=jpg&quality=50");
            },
          ),
        },
      ),
    );
  }
}


  void _showLocationInfo(BuildContext context, String locationName, String description, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(locationName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(description),
              SizedBox(height: 10),
              Image.network(imageUrl), // Resmi görüntülemek için
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'yu kapat
              },
              child: Text('Kapat'),
            ),
          ],
        );
      },
    );
  }



*/





/*  ilk yaptığım harita ksımı

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final String apiKey = 'AIzaSyAqoYtOZPlJ48ubFAMKi55DJNVexkc3b3U'; // API anahtarınızı buraya ekleyin
    // AIzaSyAqoYtOZPlJ48ubFAMKi55DJNVexkc3b3U
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gez ve gör || Kültürel Şok'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Başlangıç konumu
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: {
          Marker(
            markerId: MarkerId('marker_1'),
            position: LatLng(37.7749, -122.4194), // İstediğiniz koordinat
            infoWindow: InfoWindow(title: 'Konumunuz'),
          ),
        },
      ),
    );
  }
}

*/