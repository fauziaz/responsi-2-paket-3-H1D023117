import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/helpers/user_info.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/login_page.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );

  // WARNA COKLAT UTAMA
  final Color warnaUtama = const Color(0xFF4B382A);
  final Color backgroundColor = const Color(0xFFF5EFE9);

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    var token = await UserInfo().getToken();
    setState(() {
      if (token != null) {
        page = const ProdukPage();
      } else {
        page = const LoginPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris Buku',
      debugShowCheckedModeBanner: false,

      // ================================================
      // ###########  GLOBAL THEME WARNA COKLAT  ###########
      // ================================================
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: warnaUtama,
        scaffoldBackgroundColor: backgroundColor,

        appBarTheme: AppBarTheme(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: warnaUtama),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: warnaUtama, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: warnaUtama),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: warnaUtama,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      home: page,
    );
  }
}