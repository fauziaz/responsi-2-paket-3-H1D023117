import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/bloc/login_bloc.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/helpers/user_info.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_page.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/registrasi_page.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  final Color primary = const Color(0xff4B382A);
  final Color softBrown = const Color(0xffA1887F);
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
              // ICON BUKU
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
                "Fauziamart Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Selamat datang kembali 👋",
                style: TextStyle(color: primary.withOpacity(0.7)),
              ),
              const SizedBox(height: 35),

              // CARD LOGIN
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
                      _emailTextField(),
                      const SizedBox(height: 15),
                      _passwordTextField(),
                      const SizedBox(height: 25),
                      _loginButton(),
                      const SizedBox(height: 15),
                      _menuRegistrasi(),
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

  // TEXTFIELD EMAIL
  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.email_outlined, color: Colors.brown[800]),
        filled: true,
        fillColor: const Color(0xffF7F2EB),
        labelStyle: TextStyle(color: Colors.brown[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      controller: _emailTextboxController,
      validator: (value) =>
          value!.isEmpty ? "Email harus diisi" : null,
    );
  }

  // TEXTFIELD PASSWORD
  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock_outline, color: Colors.brown[800]),
        filled: true,
        fillColor: const Color(0xffF7F2EB),
        labelStyle: TextStyle(color: Colors.brown[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) =>
          value!.isEmpty ? "Password harus diisi" : null,
    );
  }

  // LOGIN BUTTON
  Widget _loginButton() {
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
                "Login",
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

  void _submit() {
    setState(() => _isLoading = true);

    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProdukPage()),
        );
      } else {
        _showErrorDialog();
      }
    }).catchError((_) {
      _showErrorDialog();
    }).whenComplete(() {
      setState(() => _isLoading = false);
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const WarningDialog(
        description: "Login gagal, silahkan coba lagi",
      ),
    );
  }

  // MENU REGISTRASI
  Widget _menuRegistrasi() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RegistrasiPage()),
        );
      },
      child: Text(
        "Belum punya akun? Registrasi",
        style: TextStyle(
          color: const Color(0xff4B382A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}