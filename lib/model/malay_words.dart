// lib/models/malay_words.dart
import 'package:flutter/material.dart';

enum WordCategory {
  kataNamaAm,
  kataNamaKhas,
  kataNamaDiri,
  kataNamaBilangan,
  kataTunjuk,
  kataKerjaAsas,
  kataKerjaBer,
  kataKerjaMe,
  kataKerjaTer,
  kataKerjaSuruhan,
  warnaKataSifat,
  saizKataSifat,
  rasaKataSifat,
  emosiKataSifat,
  sifatKataSifat,
  kataHubung,
}

// In lib/model/malay_words.dart

// Add this map after your WordCategory enum
final Map<WordCategory, String> malayCategoryNames = {
  WordCategory.kataNamaAm: 'Kata Nama Am',
  WordCategory.kataNamaKhas: 'Kata Nama Khas',
  WordCategory.kataNamaDiri: 'Kata Ganti Nama Diri',
  WordCategory.kataNamaBilangan: 'Kata Nama Bilangan',
  WordCategory.kataTunjuk: 'Kata Tunjuk',
  WordCategory.kataKerjaAsas: 'Kata Kerja Asas',
  WordCategory.kataKerjaBer: 'Kata Kerja dengan ber-',
  WordCategory.kataKerjaMe: 'Kata Kerja dengan me-',
  WordCategory.kataKerjaTer: 'Kata Kerja dengan ter-',
  WordCategory.kataKerjaSuruhan: 'Kata Kerja Suruhan',
  WordCategory.warnaKataSifat: 'Kata Sifat - Warna',
  WordCategory.saizKataSifat: 'Kata Sifat - Saiz',
  WordCategory.rasaKataSifat: 'Kata Sifat - Rasa',
  WordCategory.emosiKataSifat: 'Kata Sifat - Emosi',
  WordCategory.sifatKataSifat: 'Kata Sifat - Sifat',
  WordCategory.kataHubung: 'Kata Hubung',
};

class MalayWord {
  final String word;
  final String meaning;
  final String example;
  final WordCategory category;

  MalayWord({
    required this.word,
    required this.meaning,
    required this.example,
    required this.category,
  });
}

final Map<WordCategory, List<MalayWord>> malayWords = {
  WordCategory.kataNamaAm: [
    MalayWord(
        word: "buku",
        meaning: "book",
        example: "Ini buku saya",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "kerusi",
        meaning: "chair",
        example: "Kerusi itu baru",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "meja",
        meaning: "table",
        example: "Meja ini besar",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "pensel",
        meaning: "pencil",
        example: "Saya menulis dengan pensel",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "kasut",
        meaning: "shoes",
        example: "Kasut saya berwarna hitam",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "bola",
        meaning: "ball",
        example: "Adik suka bermain bola",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "rumah",
        meaning: "house",
        example: "Rumah kami besar",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "telefon",
        meaning: "phone",
        example: "Ini telefon baharu",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "kereta",
        meaning: "car",
        example: "Ayah memandu kereta",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "botol",
        meaning: "bottle",
        example: "Botol air saya kosong",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "komputer",
        meaning: "computer",
        example: "Saya menggunakan komputer",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "pintu",
        meaning: "door",
        example: "Tolong tutup pintu",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "tingkap",
        meaning: "window",
        example: "Buka tingkap itu",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "beg",
        meaning: "bag",
        example: "Beg sekolah saya berat",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "jam",
        meaning: "clock/watch",
        example: "Jam menunjukkan pukul lapan",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "televisyen",
        meaning: "television",
        example: "Kami menonton televisyen",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "kipas",
        meaning: "fan",
        example: "Kipas itu berputar",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "lampu",
        meaning: "lamp/light",
        example: "Lampu bilik tidur",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "katil",
        meaning: "bed",
        example: "Katil ini sangat selesa",
        category: WordCategory.kataNamaAm),
    MalayWord(
        word: "almari",
        meaning: "cupboard",
        example: "Almari pakaian saya penuh",
        category: WordCategory.kataNamaAm),
  ],
  WordCategory.kataNamaKhas: [
    MalayWord(
        word: "Ali",
        meaning: "Boy's name",
        example: "Ali pergi ke sekolah",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Malaysia",
        meaning: "Country name",
        example: "Saya cinta Malaysia",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Kuala Lumpur",
        meaning: "City name",
        example: "Kuala Lumpur ibu negara Malaysia",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Ahmad",
        meaning: "Boy's name",
        example: "Ahmad rajin membaca",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Siti",
        meaning: "Girl's name",
        example: "Siti pandai memasak",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Pulau Pinang",
        meaning: "State name",
        example: "Pulau Pinang terkenal dengan makanan",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Putrajaya",
        meaning: "City name",
        example: "Putrajaya pusat pentadbiran",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Melaka",
        meaning: "State name",
        example: "Melaka bandaraya bersejarah",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Johor",
        meaning: "State name",
        example: "Johor di selatan Malaysia",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Rahman",
        meaning: "Boy's name",
        example: "Rahman suka bermain bola",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Fatimah",
        meaning: "Girl's name",
        example: "Fatimah seorang guru",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Sabah",
        meaning: "State name",
        example: "Sabah negeri di bawah bayu",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Sarawak",
        meaning: "State name",
        example: "Sarawak negeri terbesar",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "KLCC",
        meaning: "Building name",
        example: "KLCC ialah menara berkembar",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Langkawi",
        meaning: "Island name",
        example: "Langkawi pulau pelancongan",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Pahang",
        meaning: "State name",
        example: "Pahang negeri terbesar di Semenanjung",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Kedah",
        meaning: "State name",
        example: "Kedah jelapang padi",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Kelantan",
        meaning: "State name",
        example: "Kelantan negeri budaya",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Terengganu",
        meaning: "State name",
        example: "Terengganu negeri cantik",
        category: WordCategory.kataNamaKhas),
    MalayWord(
        word: "Perlis",
        meaning: "State name",
        example: "Perlis negeri terkecil",
        category: WordCategory.kataNamaKhas),
  ],
  WordCategory.kataNamaDiri: [
    MalayWord(
        word: "saya",
        meaning: "I/me",
        example: "Saya suka membaca",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "awak",
        meaning: "you",
        example: "Awak mahu ke mana?",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "dia",
        meaning: "he/she",
        example: "Dia sedang tidur",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "kami",
        meaning: "we (exclusive)",
        example: "Kami pergi ke sekolah",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "kita",
        meaning: "we (inclusive)",
        example: "Kita makan sama-sama",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "mereka",
        meaning: "they",
        example: "Mereka bermain di taman",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "anda",
        meaning: "you (formal)",
        example: "Anda diperlukan di pejabat",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "beliau",
        meaning: "he/she (formal)",
        example: "Beliau seorang doktor",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "engkau",
        meaning: "you (informal)",
        example: "Engkau hendak ke mana?",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "baginda",
        meaning: "his/her majesty",
        example: "Baginda bertitah",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "patik",
        meaning: "I (to royalty)",
        example: "Patik mohon ampun",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "beta",
        meaning: "I (royalty)",
        example: "Beta berkenan",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "hamba",
        meaning: "I (humble)",
        example: "Hamba mohon maaf",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "tuan",
        meaning: "sir",
        example: "Tuan punya rumah",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "puan",
        meaning: "madam",
        example: "Puan guru sudah tiba",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "encik",
        meaning: "mister",
        example: "Encik Ahmad ada di rumah",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "cik",
        meaning: "miss",
        example: "Cik Siti mengajar matematik",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "kalian",
        meaning: "you all",
        example: "Kalian semua hadir",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "sendiri",
        meaning: "self",
        example: "Saya buat sendiri",
        category: WordCategory.kataNamaDiri),
    MalayWord(
        word: "diri",
        meaning: "self (formal)",
        example: "Jaga diri baik-baik",
        category: WordCategory.kataNamaDiri),
  ],
  WordCategory.kataNamaBilangan: [
    MalayWord(
        word: "satu",
        meaning: "one",
        example: "Saya ada satu buku",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "dua",
        meaning: "two",
        example: "Dua orang pelajar",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "tiga",
        meaning: "three",
        example: "Tiga ekor kucing",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "empat",
        meaning: "four",
        example: "Empat buah kereta",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "lima",
        meaning: "five",
        example: "Lima biji telur",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "enam",
        meaning: "six",
        example: "Enam batang pensel",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "tujuh",
        meaning: "seven",
        example: "Tujuh helai kertas",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "lapan",
        meaning: "eight",
        example: "Lapan keping roti",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "sembilan",
        meaning: "nine",
        example: "Sembilan orang murid",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "sepuluh",
        meaning: "ten",
        example: "Sepuluh biji limau",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "sebelas",
        meaning: "eleven",
        example: "Sebelas orang pemain",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "puluh",
        meaning: "tens",
        example: "Dua puluh ringgit",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "ratus",
        meaning: "hundreds",
        example: "Lima ratus orang",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "ribu",
        meaning: "thousands",
        example: "Seribu hari",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "pertama",
        meaning: "first",
        example: "Hari pertama sekolah",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "kedua",
        meaning: "second",
        example: "Tingkat kedua bangunan",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "ketiga",
        meaning: "third",
        example: "Anak ketiga keluarga",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "keempat",
        meaning: "fourth",
        example: "Minggu keempat bulan ini",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "kelima",
        meaning: "fifth",
        example: "Bab kelima buku",
        category: WordCategory.kataNamaBilangan),
    MalayWord(
        word: "keenam",
        meaning: "sixth",
        example: "Hari keenam minggu ini",
        category: WordCategory.kataNamaBilangan),
  ],
  WordCategory.kataTunjuk: [
    MalayWord(
        word: "ini",
        meaning: "this",
        example: "Ini buku saya",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "itu",
        meaning: "that",
        example: "Itu rumah dia",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "sini",
        meaning: "here",
        example: "Mari ke sini",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "situ",
        meaning: "there",
        example: "Letak di situ",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "sana",
        meaning: "over there",
        example: "Dia pergi ke sana",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "begini",
        meaning: "like this",
        example: "Buat begini",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "begitu",
        meaning: "like that",
        example: "Jangan buat begitu",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "tersebut",
        meaning: "mentioned",
        example: "Buku tersebut hilang",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "demikian",
        meaning: "thus/such",
        example: "Demikian ceritanya",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "di sini",
        meaning: "right here",
        example: "Letakkan di sini",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "di situ",
        meaning: "right there",
        example: "Duduk di situ",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "di sana",
        meaning: "over there",
        example: "Mereka tinggal di sana",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "ke sini",
        meaning: "to here",
        example: "Datang ke sini",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "ke situ",
        meaning: "to there",
        example: "Pergi ke situ",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "ke sana",
        meaning: "to over there",
        example: "Jalan ke sana",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "dari sini",
        meaning: "from here",
        example: "Mulakan dari sini",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "dari situ",
        meaning: "from there",
        example: "Ambil dari situ",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "dari sana",
        meaning: "from over there",
        example: "Datang dari sana",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "sebegini",
        meaning: "like this",
        example: "Cara sebegini lebih baik",
        category: WordCategory.kataTunjuk),
    MalayWord(
        word: "sebegitu",
        meaning: "like that",
        example: "Jangan buat sebegitu",
        category: WordCategory.kataTunjuk),
  ],
};

// Category display information
class CategoryInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final WordCategory category;
  final String description;

  CategoryInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.category,
    required this.description,
  });
}

final List<CategoryInfo> categoryList = [
  CategoryInfo(
    title: 'Kata Nama Am',
    subtitle: 'Common Nouns',
    icon: Icons.book,
    color: Colors.blue,
    category: WordCategory.kataNamaAm,
    description: 'Basic words for everyday objects',
  ),
  CategoryInfo(
    title: 'Kata Nama Khas',
    subtitle: 'Proper Nouns',
    icon: Icons.person,
    color: Colors.green,
    category: WordCategory.kataNamaKhas,
    description: 'Names of specific places and people',
  ),
  CategoryInfo(
    title: 'Kata Ganti Nama Diri',
    subtitle: 'Pronouns',
    icon: Icons.people,
    color: Colors.orange,
    category: WordCategory.kataNamaDiri,
    description: 'Words like I, you, he/she',
  ),
  CategoryInfo(
    title: 'Kata Nama Bilangan',
    subtitle: 'Number Nouns',
    icon: Icons.numbers,
    color: Colors.purple,
    category: WordCategory.kataNamaBilangan,
    description: 'Words for counting and numbers',
  ),
  CategoryInfo(
    title: 'Kata Tunjuk',
    subtitle: 'Demonstrative Words',
    icon: Icons.gesture,
    color: Colors.teal,
    category: WordCategory.kataTunjuk,
    description: 'Words like this and that',
  ),
// Add more categories following the same pattern
  // Add more categories...
];
