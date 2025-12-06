import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/bloc/registrasi_bloc.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/widget/success_dialog.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/widget/warning_dialog.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/login_page.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  final _passwordKonfirmasiController = TextEditingController();

  final Color primary = const Color(0xff4B382A);
  final Color cream = const Color(0xffF3E9D7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ICON
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),

              Text(
                "Registrasi Fauziamart",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Buat akun baru dulu yuk ✨",
                style: TextStyle(color: primary.withOpacity(0.7)),
              ),
              const SizedBox(height: 35),

              // CARD
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _namaTextField(),
                      const SizedBox(height: 15),
                      _emailTextField(),
                      const SizedBox(height: 15),
                      _passwordTextField(),
                      const SizedBox(height: 15),
                      _passwordKonfirmasiTextField(),
                      const SizedBox(height: 25),
                      _buttonRegistrasi(),
                      const SizedBox(height: 15),
                      _menuLogin(),   // <<< DITAMBAHKAN DI SINI
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // INPUT DECORATION
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.brown[800]),
      filled: true,
      fillColor: const Color(0xffF7F2EB),
      labelStyle: TextStyle(color: Colors.brown[800]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  // NAMA
  Widget _namaTextField() {
    return TextFormField(
      decoration: _inputDecoration("Nama", Icons.person_outline),
      controller: _namaTextboxController,
      validator: (value) =>
          value!.length < 3 ? "Nama minimal 3 karakter" : null,
    );
  }

  // EMAIL
  Widget _emailTextField() {
    return TextFormField(
      decoration: _inputDecoration("Email", Icons.email_outlined),
      controller: _emailTextboxController,
      validator: (value) =>
          value!.isEmpty ? "Email harus diisi" : null,
    );
  }

  // PASSWORD
  Widget _passwordTextField() {
    return TextFormField(
      decoration: _inputDecoration("Password", Icons.lock_outline),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) =>
          value!.length < 6 ? "Password minimal 6 karakter" : null,
    );
  }

  // KONFIRMASI PASSWORD
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: _inputDecoration("Konfirmasi Password", Icons.lock_outline),
      obscureText: true,
      controller: _passwordKonfirmasiController,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  // BUTTON REGISTRASI
  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff4B382A),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "Registrasi",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
        onPressed: () {
          if (_formKey.currentState!.validate() && !_isLoading) {
            _submit();
          }
        },
      ),
    );
  }

  // MENU LOGIN (BARU)
  Widget _menuLogin() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
      child: Text(
        "Sudah punya akun? Login di sini",
        style: TextStyle(
          color: const Color(0xff4B382A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // SUBMIT
  void _submit() {
    setState(() => _isLoading = true);

    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SuccessDialog(
          description: "Registrasi berhasil, silahkan login",
          okClick: () => Navigator.pop(context),
        ),
      );
    }).catchError((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const WarningDialog(
          description: "Registrasi gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }
}