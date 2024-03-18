class Yer {
  final int id;
  final String sehir;
  final String baslik;
  final String aciklama;
  final double latitude;
  final double longitude;
  final String gorselUrl;

  Yer({
    required this.id,
    required this.sehir,
    required this.baslik,
    required this.aciklama,
    required this.latitude,
    required this.longitude,
    required this.gorselUrl,
  });
}

// Örnek yerlerin listesi
List<Yer> yerlerListesi = [
  Yer(
    id: 1,
    sehir: 'Çanakkale',
    baslik: 'Çanakkale Kale',
    aciklama: 'Çanakkale Kalesi, Çanakkale Boğazı kıyısında bulunan tarihi bir kaledir.',
    latitude: 40.1548,
    longitude: 26.4143,
    gorselUrl: 'https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20180319134434287_KILITBAHIR.jpg?format=jpg&quality=50',
  ),
  Yer(
    id: 2,
    sehir: 'Çanakkale',
    baslik: 'Çanakkale Saat Kulesi',
    aciklama: 'Çanakkale Saat Kulesi, şehrin sembolik bir yapısıdır ve tarihi bir kuledir.',
    latitude: 40.1550,
    longitude: 26.4130,
    gorselUrl: 'https://www.gezilesiyer.com/wp-content/uploads/2015/03/canakkale-saat-kulesi-gezilesiyer.jpg',
  ),
  Yer(
    id: 3,
    sehir: 'Çanakkale',
    baslik: 'Çanakkale Arkeoloji Müzesi',
    aciklama: 'Çanakkale Arkeoloji Müzesi, bölgenin tarihini ve kültürünü sergileyen önemli bir müzedir.',
    latitude: 40.1555,
    longitude: 26.4155,
    gorselUrl: 'https://www.gezilesiyer.com/wp-content/uploads/2015/03/canakkale-arkeoloji-muzesi-ic.jpg',
  ),
  Yer(
    id: 4,
    sehir: 'Çanakkale',
    baslik: 'Troia Antik Kenti',
    aciklama: 'Troia Antik Kenti, efsanevi Truva Savaşının geçtiği yer olarak bilinir ve UNESCO Dünya Mirasıdır.',
    latitude: 39.5719,
    longitude: 26.1457,

    gorselUrl: 'https://blog.obilet.com/wp-content/uploads/2020/05/Troya-%C3%87anakkale-1024x683.jpeg',
  ),
  // çorlu
  Yer(
    id: 5,
    sehir: 'Çorlu',
    baslik: 'Çorlu Tarihi Camii',
    aciklama: 'Çorlu Tarihi Camii, şehirdeki en eski camilerden biridir ve tarihi bir yapısı vardır.',
    latitude: 41.1608,
    longitude: 27.8059,
    gorselUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/6e/bd/00/corlu-suleymaniye-cami.jpg?w=1200&h=-1&s=1',
  ),

  Yer(
    id: 6,
    sehir: 'Çorlu',
    baslik: 'Çorlu Müzesi',
    aciklama: 'Çorlu Müzesi, bölgenin tarihini ve kültürünü sergileyen önemli bir müzedir.',
    latitude: 41.1601,
    longitude: 27.8039,
    gorselUrl: 'https://www.corlu.bel.tr/upload/tr/resim/haberyonetimi/dji_0001_15122020103956_1020_500_id_5557.jpg',
  ),
  Yer(
    id: 7,
    sehir: 'Çorlu',
    baslik: 'Çorlu Taş Köprü',
    aciklama: 'Çorlu Taş Köprü, şehirdeki tarihi bir köprüdür ve çevresi keyifli bir yürüyüş alanı sunar.',
    latitude: 41.1645,
    longitude: 27.8053,
    gorselUrl: 'https://live.staticflickr.com/65535/49143079461_169c2e6a90_b.jpg',
  ),
  // edirne
  Yer(
    id: 8,
    sehir: 'Edirne',
    baslik: 'Edirne Selimiye Camii',
    aciklama: 'Edirne Selimiye Camii, Osmanlı İmparatorluğu döneminde inşa edilen muhteşem bir camidir ve UNESCO Dünya Mirasıdır.',
    latitude: 41.6785,
    longitude: 26.5543,
    gorselUrl: 'https://im.haberturk.com/2022/10/04/3526111_ed3ed06ead56e417754906b5e67d015e_640x640.jpg',
  ),
  Yer(
    id: 9,
    sehir: 'Edirne',
    baslik: 'Edirne Eski Camii',
    aciklama: 'Edirne Eski Camii, şehirdeki tarihi camilerden biridir ve benzersiz mimarisi ile bilinir.',
    latitude: 41.6759,
    longitude: 26.5561,
    gorselUrl: 'https://okuryazarim.com/wp-content/uploads/2020/04/Edirne-Eski-Cami.jpg',
  ),

  Yer(
    id: 10,
    sehir: 'Edirne',
    baslik: 'Edirne Tahtakale Hamamı',
    aciklama: 'Edirne Tahtakale Hamamı, tarihi bir hamamın tadını çıkarmanız için harika bir mekandır.',
    latitude: 41.6720,
    longitude: 26.5582,
    gorselUrl: 'https://edirne.web.tr/Fotograflar/Hamamlar/saray-hamami-2-1.jpg',
  ),

  Yer(
    id: 11,
    sehir: 'Edirne',
    baslik: 'Edirne Deliler Hastanesi',
    aciklama: 'Edirne Deliler Hastanesi, şehirdeki tarihi bir hastanedir ve önemli bir kültürel mirastır.',
    latitude: 41.6677,
    longitude: 26.5600,
    gorselUrl: 'https://www.trakyagezi.com/wp-content/uploads/2020/11/%C4%B0maret-M%C3%BCzesi-1-@-U%C4%9Fur-Kaygusuz.jpg',
  ),


  Yer(
    id: 12,
    sehir: 'İstanbul',
    baslik: 'Galata Kukesi',
    aciklama: 'Galata kulesi tarihi yapı olara... hakkında açıklaması',
    latitude: 41.025658,
    longitude: 28.974155,

    gorselUrl: 'https://assets.orayanasilgiderim.com/destination-img/galata-kulesi.jpg',
  ),





  // Daha fazla yer eklemeye devam edebilirsiniz  ----


  Yer(
    id: 13,
    sehir: 'Ankara',
    baslik: 'Ankara Kalesi',
    aciklama: 'Ankara Kalesi, başkent Ankara\'nın sembollerinden biridir ve tarihi bir kaledir.',
    latitude: 39.9389,
    longitude: 32.8541,
    gorselUrl: 'https://www.kulturportali.gov.tr/contents/images/ANKARA-HAVADAN%20ULUS-HAM%C4%B0T%20HAL%C3%87IN%20(2)%20logolu.jpg',
  ),

  Yer(
    id: 14,
    sehir: 'İzmir',
    baslik: 'İzmir Saat Kulesi',
    aciklama: 'İzmir Saat Kulesi, İzmir\'in en tanınmış simgelerinden biridir ve tarihi bir kuledir.',
    latitude: 38.4189,
    longitude: 27.1287,
    gorselUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/db/d5/b2/saat-kulesi.jpg?w=1200&h=-1&s=1',
  ),

  Yer(
    id: 15,
    sehir: 'Antalya',
    baslik: 'Antalya Kaleiçi',
    aciklama: 'Antalya Kaleiçi, Antalya\'nın tarihi merkezi ve turistik bir cazibe merkezidir.',
    latitude: 36.8841,
    longitude: 30.7054,
    gorselUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/50/70/c5/harbour-from-lift.jpg?w=1200&h=-1&s=1',
  ),

  Yer(
    id: 16,
    sehir: 'Kapadokya',
    baslik: 'Cappadocia Peri Bacaları',
    aciklama: 'Kapadokya\'daki Peri Bacaları, benzersiz kaya oluşumları ve yer altı şehirleri ile ünlüdür.',
    latitude: 38.6431,
    longitude: 34.8307,
    gorselUrl: 'https://mdchotel.com/blog/wp-content/uploads/2021/10/peri-bacasi..jpg',
  ),

  Yer(
    id: 17,
    sehir: 'Ağrı',
    baslik: 'Ağrı Dağı',
    aciklama: 'Ağrı Dağı, Türkiye\'nin en yüksek dağıdır ve efsanevi Nuhun Gemisinin karaya oturduğu yer olarak kabul edilir.',
    latitude: 39.6982,
    longitude: 44.2985,
    gorselUrl: 'https://idsb.tmgrup.com.tr/ly/uploads/images/2020/07/16/46706.jpg',
  ),

  Yer(
    id: 18,
    sehir: 'İzmir',
    baslik: 'Ephesus Antik Kenti',
    aciklama: 'Efes Antik Kenti, İzmir iline yakın ve büyüleyici bir tarihi kalıntıları içerir.',
    latitude: 37.9394,
    longitude: 27.3414,
    gorselUrl: 'https://www.kulturportali.gov.tr/repoKulturPortali/large/SehirRehberi//GezilecekYer/20170503221038375_e5.JPG?format=jpg&quality=50',
  ),


  Yer(
    id: 19,
    sehir: 'Adıyaman',
    baslik: 'Nemrut Dağı Tümülüsü',
    aciklama: 'Nemrut Dağı Tümülüsü, Kommagene Krallığı dönemine ait büyüleyici bir tarihi anıttır.',
    latitude: 37.9746,
    longitude: 38.7416,
    gorselUrl: 'https://i.imgur.com/FZx55j9.jpg',
  ),

  Yer(
    id: 20,
    sehir: 'Safranbolu',
    baslik: 'Safranbolu Evleri',
    aciklama: 'Safranbolu, Osmanlı dönemi evleri ile ünlüdür ve UNESCO Dünya Mirası Listesi\'ndedir.',
    latitude: 41.2628,
    longitude: 32.6870,
    gorselUrl: 'https://www.sixt.com.tr/storage/cache/e1d239f79d70e72bd1ce0f7ec7aba1f118ee9cbe.webp',
  ),

  Yer(
    id: 21,
    sehir: 'Şanlıurfa',
    baslik: 'Göbeklitepe',
    aciklama: 'Göbeklitepe, dünyanın en eski tapınak kompleksi olarak kabul edilir ve önemli bir arkeolojik keşiftir.',
    latitude: 37.2231,
    longitude: 38.9222,
    gorselUrl: 'https://perapalace.com/wp-content/uploads/2022/01/Gobeklitepe-ilk-tapinak-e1581682095713.jpg',
  ),

  Yer(
    id: 22,
    sehir: 'Trabzon',
    baslik: 'Sumela Manastırı',
    aciklama: 'Sümela Manastırı, Karadeniz bölgesinin eşsiz manastırlarından biridir ve doğal güzellikleri ile ünlüdür.',
    latitude: 40.7812,
    longitude: 39.6223,
    gorselUrl: 'https://www.hafsatur.com/wp-content/uploads/2021/01/sumela-manastiri-7.jpg.webp',
  ),



  Yer(
    id: 23,
    sehir: 'Pamukkale',
    baslik: 'Pamukkale Travertenleri',
    aciklama: 'Pamukkale Travertenleri, beyaz kireç taşları ve termal sularıyla ünlü doğal bir harika.',
    latitude: 37.9231,
    longitude: 29.1200,
    gorselUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/16/4c/17/merveilleux.jpg?w=1200&h=-1&s=1',
  ),

  Yer(
    id: 24,
    sehir: 'Antalya',
    baslik: 'Aspendos Antik Tiyatrosu',
    aciklama: 'Aspendos Antik Tiyatrosu, Roma dönemine ait muhteşem bir antik tiyatro.',
    latitude: 36.9166,
    longitude: 31.1245,
    gorselUrl: 'https://cdnuploads.aa.com.tr/uploads/Contents/2021/06/03/thumbs_b_c_bd7e7ff7ba721342ad991b00e99f91a7.jpg?v=113934',
  ),

  Yer(
    id: 25,
    sehir: 'Antakya',
    baslik: 'Antakya Mozaik Müzesi',
    aciklama: 'Antakya Mozaik Müzesi, antik Roma dönemine ait muhteşem mozaiklerle dolu bir müze.',
    latitude: 36.1542,
    longitude: 36.1503,
    gorselUrl: 'https://www.kulturportali.gov.tr/contents/images/20170918150419083_HATAY%20MUZESI%20GULCANACAR%20(23)(1).jpg',
  ),

  Yer(
    id: 26,
    sehir: 'Bitlis',
    baslik: 'Süphan Dağı',
    aciklama: 'Süphan Dağı, Van Gölü yakınında etkileyici bir volkanik dağdır ve doğa severler için harika bir destinasyondur.',
    latitude: 38.9110,
    longitude: 42.4445,
    gorselUrl: 'https://live.staticflickr.com/4360/36529147386_a4acd84615_b.jpg',
  ),


  Yer(
    id: 27,
    sehir: 'Bitlis',
    baslik: 'Nemrut Krater Gölü',
    aciklama: 'Nemrut Krater Gölü, Doğu Anadolu Bölgesi\'nde bulunan volkanik bir krater gölüdür.',
    latitude: 38.4600,
    longitude: 42.0296,
    gorselUrl: 'https://cdnuploads.aa.com.tr/uploads/Contents/2019/09/13/thumbs_b_c_5179cabe4e3f48af450f4575418d8b54.jpg',
  ),

  Yer(
    id: 28,
    sehir: 'İzmir',
    baslik: 'Şirince Köyü',
    aciklama: 'Şirince Köyü, İzmir iline bağlı küçük bir tarihi köydür ve üzüm bağlarıyla ünlüdür.',
    latitude: 37.9491,
    longitude: 27.4264,
    gorselUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/c4/6f/78/sirince.jpg?w=1200&h=-1&s=1',
  ),

  Yer(
    id: 29,
    sehir: 'İstanbul',
    baslik: 'Ayasofya',
    aciklama: 'Ayasofya, İstanbul\'un en önemli tarihi yapılarından biridir ve Bizans döneminin anıtsal eserlerinden biri olarak kabul edilir.',
    latitude: 41.0082,
    longitude: 28.9784,
    gorselUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Aya_Sophia_%287144824757%29.jpg/1200px-Aya_Sophia_%287144824757%29.jpg',
  ),

  Yer(
    id: 30,
    sehir: 'Kapadokya',
    baslik: 'Ihlara Vadisi',
    aciklama: 'Ihlara Vadisi, Kapadokya bölgesinde bulunan muhteşem bir doğa harikasıdır ve tarihi manastırlarla doludur.',
    latitude: 38.1103,
    longitude: 34.3186,
    gorselUrl: 'https://cdnuploads.aa.com.tr/uploads/Contents/2021/08/09/thumbs_b_c_86d48e39bb3c16ae4386f36eb0b03881.jpg',
  ),

  Yer(
    id: 31,
    sehir: 'Gaziantep',
    baslik: 'Zeugma Mozaik Müzesi',
    aciklama: 'Zeugma Mozaik Müzesi, Gaziantep\'teki antik mozaiklerin sergilendiği bir müzedir.',
    latitude: 37.0879,
    longitude: 37.3824,
    gorselUrl: 'https://trthaberstatic.cdn.wp.trt.com.tr/resimler/1896000/zeugma-mozaik-muzesi-aa-1897511.jpg',
  ),

  Yer(
    id: 32,
    sehir: 'Fethiye - Muğla',
    baslik: 'Öludeniz Plajı',
    aciklama: 'Ölüdeniz, dünyanın en güzel plajlarından birine sahiptir ve sakin sularıyla ünlüdür.',
    latitude: 36.5546,
    longitude: 29.1231,
    gorselUrl: 'https://bujuyollarda.com/wp-content/uploads/2023/06/oludeniz-plaji-gezi-rehberi.jpg',
  ),

  Yer(
    id: 33,
    sehir: 'Kapadokya',
    baslik: 'Mount Hasan',
    aciklama: 'Hasan Dağı, Kapadokya bölgesinin etkileyici bir yanardağıdır ve doğa tutkunları için harika bir destinasyondur.',
    latitude: 38.1157,
    longitude: 34.1887,
    gorselUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Hasan_Da%C4%9F%C4%B1.jpg',
  ),



  Yer(
    id: 34,
    sehir: 'Aydın',
    baslik: 'Aphrodisias Antik Kenti',
    aciklama: 'Afrodisyas, Antik Roma dönemine ait bir antik kenttir ve antik tiyatrosu ile ünlüdür.',
    latitude: 37.7420,
    longitude: 28.7136,
    gorselUrl: 'https://visitaydin.com/media/2022/04/YENIuygarlik_kavsaginda_oguz_ipci_aphrodisias_karacasu_aydin.jpg',
  ),

  Yer(
    id: 35,
    sehir: 'Adıyaman',
    baslik: 'Nemrut Dağı Güneş Tapınağı',
    aciklama: 'Nemrut Dağı Güneş Tapınağı, Kommagene Krallığı dönemine ait büyüleyici bir tarihi anıttır.',
    latitude: 37.9795,
    longitude: 38.7460,
    gorselUrl: 'https://www.hisglobal.com.tr/assets/images/uploads/1598444401.jpg',
  ),

  Yer(
    id: 36,
    sehir: 'İstanbul',
    baslik: 'Sultan Ahmet Camii',
    aciklama: 'Sultan Ahmet Camii, İstanbul\'un tarihi yarımadasında yer alan ünlü bir camiidir ve Mavi Camii olarak da bilinir.',
    latitude: 41.0055,
    longitude: 28.9769,
    gorselUrl: 'https://www.kulturportali.gov.tr/contents/images/474.jpg',
  ),

  Yer(
    id: 37,
    sehir: 'Konya',
    baslik: 'Cennet ve Cehennem Obrukları',
    aciklama: 'Cennet ve Cehennem Obrukları, Konya ilinde yer alan doğal oluşumlardır ve keşfedilmeyi bekliyorlar.',
    latitude: 37.8689,
    longitude: 32.4973,
    gorselUrl: 'https://trthaberstatic.cdn.wp.trt.com.tr/resimler/1306000/1306522.jpg',
  ),

  Yer(
    id: 38,
    sehir: 'Mardin',
    baslik: 'Mardin Kalesi',
    aciklama: 'Mardin Kalesi, Mardin şehrinin tarihi merkezinde bulunan etkileyici bir kaledir.',
    latitude: 37.3180,
    longitude: 40.7397,
    gorselUrl: 'https://gezicini.com/wp-content/uploads/2020/10/mardinkalesi.jpg',
  ),



  Yer(
    id: 39,
    sehir: 'Antalya',
    baslik: 'Patara Antik Kenti',
    aciklama: 'Patara, antik Roma dönemine ait bir kent olup güzel plajları ve tarihi kalıntıları ile ünlüdür.',
    latitude: 36.2639,
    longitude: 29.3279,
    gorselUrl: 'https://www.kulturportali.gov.tr/contents/images/ANTALYA-PATARA-G%C3%9CLCANACAR%20(11)(1).jpg',
  ),



  Yer(
    id: 40,
    sehir: 'Aydın',
    baslik: 'Dilek Yarımadası Milli Parkı',
    aciklama: 'Dilek Yarımadası Milli Parkı, Ege Bölgesi\'nde doğal güzellikleri ve plajları ile ünlüdür.',
    latitude: 37.8670,
    longitude: 27.2200,
    gorselUrl: 'https://www.hepsiburadaseyahat.com/blog/wp-content/uploads/2022/09/dilek-yarimadasi-scaled.jpg',
  ),

  Yer(
    id: 41,
    sehir: 'Alanya',
    baslik: 'Alanya Kalesi',
    aciklama: 'Alanya Kalesi, güzel deniz manzarasıyla ünlüdür ve tarihi kalıntıları içerir.',
    latitude: 36.5522,
    longitude: 32.0055,
    gorselUrl: 'https://muzeler.org/images/google-place-images/alanya-kalesi.jpg',
  ),

  Yer(
    id: 42,
    sehir: 'Hatay',
    baslik: 'Harran Köyü',
    aciklama: 'Harran, geleneksel kerpiç evleri ile ünlü bir Mezopotamya köyüdür.',
    latitude: 36.8670,
    longitude: 39.0148,
    gorselUrl: 'https://pbs.twimg.com/media/D9mlkKpWkAEmCN6?format=jpg&name=4096x4096',
  ),



  Yer(
    id: 43,
    sehir: 'Fethiye - Muğla',
    baslik: 'Tlos Antik Kenti',
    aciklama: 'Tlos Antik Kenti, Likya dönemine ait tarihi kalıntıları ve mezarları ile ünlüdür.',
    latitude: 36.5657,
    longitude: 29.4473,
    gorselUrl: 'https://i0.wp.com/cloudbasetravel.com/wp-content/uploads/2021/07/tlos.jpg',
  ),

  Yer(
    id: 44,
    sehir: 'Kütahya',
    baslik: 'Aizonai Antik Kenti',
    aciklama: 'Aizonai Antik Kenti, Phrygia bölgesine ait tarihi bir antik kenttir ve arkeoloji meraklıları için ilgi çekicidir.',
    latitude: 38.5484,
    longitude: 29.6730,
    gorselUrl: 'https://www.kulturportali.gov.tr/contents/images/YA%20DA(1).jpg',
  ),

  Yer(
    id: 45,
    sehir: 'Çeşme',
    baslik: 'Cesme Plajları',
    aciklama: 'Çeşme, muhteşem plajları, rüzgar sörfü ve sıcak termal suları ile ünlü bir tatil beldesidir.',
    latitude: 38.3190,
    longitude: 26.3191,
    gorselUrl: 'https://gezicini.com/wp-content/uploads/2019/06/ilicahalkplaji-e1606648160274.jpg',
  ),

  Yer(
    id: 46,
    sehir: 'Afyonkarahisar',
    baslik: 'Afyonkarahisar Kalesi',
    aciklama: 'Afyonkarahisar Kalesi, Afyon ilinin sembolik yapılarından biridir ve tarihi kalıntıları içerir.',
    latitude: 38.7614,
    longitude: 30.5382,
    gorselUrl: 'https://i0.wp.com/dronepilotlari.net/wp-content/uploads/2020/01/Afyon_kalesi_manset.jpg?fit=650%2C360&ssl=1',
  ),

  Yer(
    id: 47,
    sehir: 'Nevşehir',
    baslik: 'Göreme Açık Hava Müzesi',
    aciklama: 'Göreme Açık Hava Müzesi, Kapadokya bölgesindeki benzersiz kaya kiliseleri ile ünlüdür.',
    latitude: 38.6435,
    longitude: 34.8274,
    gorselUrl: 'https://cappadocia4u.com/tr/wp-content/uploads/goreme-open-air-museum.jpg',
  ),

  Yer(
    id: 48,
    sehir: 'Bodrum',
    baslik: 'Bodrum Kalesi',
    aciklama: 'Bodrum Kalesi, Bodrum şehrinin tarihi merkezinde bulunan bir kaledir ve deniz manzarası sunar.',
    latitude: 37.0353,
    longitude: 27.4281,
    gorselUrl: 'https://cdnuploads.aa.com.tr/uploads/Contents/2023/01/25/thumbs_b_c_fce76dec87d24942d4b4136a4b936079.jpg?v=163248',
  ),

  Yer(
    id: 49,
    sehir: 'Marmaris',
    baslik: 'Marmaris Koyları',
    aciklama: 'Marmaris, muhteşem koyları ve deniz sporları fırsatları ile ünlüdür.',
    latitude: 36.8564,
    longitude: 28.2666,
    gorselUrl: 'https://www.flypgs.com/blog/wp-content/uploads/2021/06/marmarisin-en-guzel-plajlari.jpg',
  ),

  /*  // karabiberim vur kadehlere hadi içelim
  Yer(
    baslik: 'Amasra Kalesi',
    aciklama: 'Amasra Kalesi, Karadeniz kıyısında yer alan tarihi bir kale ve müze olarak kullanılmaktadır.',
    latitude: 41.7425,
    longitude: 32.3878,
    gorselUrl: 'https://www.example.com/amasra-kalesi.jpg',
  ),

  Yer(
    baslik: 'Kekova Adaları',
    aciklama: 'Kekova Adaları, antik kalıntıları ve deniz altı harabeleri ile ünlüdür ve tekne turları için idealdir.',
    latitude: 36.1623,
    longitude: 29.7742,
    gorselUrl: 'https://www.example.com/kekova-adalari.jpg',
  ),

  Yer(
    baslik: 'Birgi Köyü',
    aciklama: 'Birgi, tarihi evleri ve termal suları ile ünlü bir Ege köyüdür ve UNESCO Dünya Mirası Listesi\'nde yer alır.',
    latitude: 38.9771,
    longitude: 27.8995,
    gorselUrl: 'https://www.example.com/birgi-koyu.jpg',
  ),

  Yer(
    baslik: 'Milet Antik Kenti',
    aciklama: 'Milet Antik Kenti, antik döneme ait önemli kalıntılara sahip ve tarihi bir arkeolojik alan.',
    latitude: 37.5181,
    longitude: 27.2696,
    gorselUrl: 'https://www.example.com/milet-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Giresun Adası',
    aciklama: 'Giresun Adası, Karadeniz\'in güzel bir ada ve doğal güzellikleri ile ünlüdür.',
    latitude: 40.6282,
    longitude: 38.4479,
    gorselUrl: 'https://www.example.com/giresun-adasi.jpg',
  ),

  Yer(
    baslik: 'Zeugma Antik Kenti',
    aciklama: 'Zeugma Antik Kenti, Gaziantep ilinde yer alan ve zengin mozaikleri ile ünlü bir antik kenttir.',
    latitude: 37.0879,
    longitude: 37.3824,
    gorselUrl: 'https://www.example.com/zeugma-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Marmara Adası',
    aciklama: 'Marmara Adası, Marmara Denizi\'nde bulunan güzel bir ada ve tatil destinasyonudur.',
    latitude: 40.3880,
    longitude: 26.3187,
    gorselUrl: 'https://www.example.com/marmara-adasi.jpg',
  ),

  Yer(
    baslik: 'Hattuşaş Antik Kenti',
    aciklama: 'Hattuşaş, Hitit İmparatorluğu dönemine ait antik bir kenttir ve UNESCO Dünya Mirası Listesi\'ndedir.',
    latitude: 40.0066,
    longitude: 34.6144,
    gorselUrl: 'https://www.example.com/hattusas-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Sultan Marshes',
    aciklama: 'Sultan Marshes, kuş gözlemcileri için ideal bir doğal yaşam alanıdır ve çeşitli kuş türlerine ev sahipliği yapar.',
    latitude: 37.2416,
    longitude: 33.1047,
    gorselUrl: 'https://www.example.com/sultan-marshes.jpg',
  ),

  Yer(
    baslik: 'Köyceğiz Gölü',
    aciklama: 'Köyceğiz Gölü, Muğla ilinin güzel doğal güzelliklerinden biridir ve tekne turları için popülerdir.',
    latitude: 36.9246,
    longitude: 28.6733,
    gorselUrl: 'https://www.example.com/koycegiz-golu.jpg',
  ),

  Yer(
    baslik: 'Phaselis Antik Kenti',
    aciklama: 'Phaselis, antik döneme ait bir kent olup güzel plajları ve antik kalıntıları ile ünlüdür.',
    latitude: 36.3673,
    longitude: 30.4779,
    gorselUrl: 'https://www.example.com/phaselis-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Kaz Dağları',
    aciklama: 'Kaz Dağları, doğal güzellikleri ve zeytinlikleri ile ünlüdür ve yürüyüşçüler için harika bir destinasyondur.',
    latitude: 39.6369,
    longitude: 26.7029,
    gorselUrl: 'https://www.example.com/kaz-daglari.jpg',
  ),

  Yer(
    baslik: 'Alacahöyük Antik Kenti',
    aciklama: 'Alacahöyük, Hitit dönemine ait antik bir kenttir ve tarihi kalıntıları içerir.',
    latitude: 40.0691,
    longitude: 33.7247,
    gorselUrl: 'https://www.example.com/alacahoyuk-antik-kenti.jpg',
  ),
  Yer(
    baslik: 'Helenapolis Antik Kenti',
    aciklama: 'Helenapolis Antik Kenti, Pamukkale yakınlarında yer alan antik bir kenttir ve tarihi kalıntıları içerir.',
    latitude: 37.9619,
    longitude: 29.1165,
    gorselUrl: 'https://www.example.com/helenapolis-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Tirebolu Kalesi',
    aciklama: 'Tirebolu Kalesi, Karadeniz sahilinde yer alan tarihi bir kaledir ve deniz manzarası sunar.',
    latitude: 40.9500,
    longitude: 38.1070,
    gorselUrl: 'https://www.example.com/tirebolu-kalesi.jpg',
  ),

  Yer(
    baslik: 'Fethiye Körfezi',
    aciklama: 'Fethiye Körfezi, muhteşem deniz ve koylarıyla ünlüdür ve yat turları için popüler bir destinasyondur.',
    latitude: 36.6084,
    longitude: 29.1157,
    gorselUrl: 'https://www.example.com/fethiye-korfezi.jpg',
  ),

  Yer(
    baslik: 'Ani Antik Kenti',
    aciklama: 'Ani, tarihi bir Ermeni kenti olup surları ve kiliseleri ile ünlüdür ve UNESCO Dünya Mirası Listesi\'ndedir.',
    latitude: 40.5152,
    longitude: 43.5785,
    gorselUrl: 'https://www.example.com/ani-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Aydos Ormanı',
    aciklama: 'Aydos Ormanı, İstanbul\'un yeşil cenneti olarak kabul edilir ve doğa tutkunları için harika bir yerdir.',
    latitude: 40.9517,
    longitude: 29.2697,
    gorselUrl: 'https://www.example.com/aydos-ormani.jpg',
  ),

  Yer(
    baslik: 'Selimiye Camii',
    aciklama: 'Selimiye Camii, Edirne\'de bulunan muhteşem bir camidir ve Osmanlı dönemi mimarisinin zirvesini temsil eder.',
    latitude: 41.6761,
    longitude: 26.5564,
    gorselUrl: 'https://www.example.com/selimiye-camii.jpg',
  ),

  Yer(
    baslik: 'Gölyazı Köyü',
    aciklama: 'Gölyazı, Bursa yakınlarında yer alan tarihi bir balıkçı köyüdür ve göl manzarası ile ünlüdür.',
    latitude: 40.2020,
    longitude: 28.5893,
    gorselUrl: 'https://www.example.com/golyazi-koyu.jpg',
  ),

  Yer(
    baslik: 'Kibyra Antik Kenti',
    aciklama: 'Kibyra, antik Roma dönemine ait önemli bir antik kenttir ve tarihi kalıntıları içerir.',
    latitude: 37.3827,
    longitude: 30.2260,
    gorselUrl: 'https://www.example.com/kibyra-antik-kenti.jpg',
  ),

  Yer(
    baslik: 'Akyaka Kiteboard Sahili',
    aciklama: 'Akyaka, rüzgar sörfü ve kitesurf yapmak için mükemmel bir sahil sunar ve doğal güzellikleriyle büyüler.',
    latitude: 37.0389,
    longitude: 28.3289,
    gorselUrl: 'https://www.example.com/akyaka-kiteboard-sahili.jpg',
  ),

  Yer(
    baslik: 'Izmir Saat Kulesi',
    aciklama: 'İzmir Saat Kulesi, İzmir\'in sembol yapılarından biridir ve tarihi bir saattir.',
    latitude: 38.4192,
    longitude: 27.1287,
    gorselUrl: 'https://www.example.com/izmir-saat-kulesi.jpg',
  ),



   */

];

