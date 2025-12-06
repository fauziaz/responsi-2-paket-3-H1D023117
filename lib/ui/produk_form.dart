import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/bloc/produk_bloc.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/model/produk.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_page.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String judulForm = "Tambah Buku Fauziamart";
  String tombolSubmit = "Simpan";

  final _judulController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _volumeController = TextEditingController();
  final _penulisController = TextEditingController();
  final _penerbitController = TextEditingController();

  Color warnaUtama = const Color(0xFF4B382A);

  @override
  void initState() {
    super.initState();

    if (widget.produk != null) {
      judulForm = "Edit Buku Fauziamart";
      tombolSubmit = "Update";

      _judulController.text = widget.produk!.judul ?? "";
      _hargaController.text = widget.produk!.harga ?? "";
      _jumlahController.text = widget.produk!.jumlah ?? "";
      _tanggalController.text = widget.produk!.tanggalMasuk ?? "";
      _volumeController.text = widget.produk!.volume ?? "";
      _penulisController.text = widget.produk!.penulis ?? "";
      _penerbitController.text = widget.produk!.penerbit ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5EFE9),
        colorSchemeSeed: warnaUtama,
        useMaterial3: true,
      ),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          title: Text(
            judulForm,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildField("Judul Buku", _judulController),
                      _buildField("Harga", _hargaController, keyboard: TextInputType.number),
                      _buildField("Jumlah", _jumlahController, keyboard: TextInputType.number),
                      _buildDateField(),
                      _buildField("Volume", _volumeController),
                      _buildField("Penulis", _penulisController),
                      _buildField("Penerbit", _penerbitController),

                      const SizedBox(height: 20),
                      _buttonSubmit(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        keyboardType: keyboard,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: warnaUtama),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: warnaUtama),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: warnaUtama, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label harus diisi";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: _tanggalController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: "Tanggal Masuk",
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.calendar_month, color: warnaUtama),
          labelStyle: TextStyle(color: warnaUtama),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: warnaUtama),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: warnaUtama, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Tanggal Masuk harus diisi";
          }
          return null;
        },
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (picked != null) {
            _tanggalController.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
      ),
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget.produk == null ? simpan() : ubah();
          }
        },
        child: Text(
          tombolSubmit,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void simpan() {
    setState(() => _isLoading = true);

    Produk newProduk = Produk(
      judul: _judulController.text,
      harga: _hargaController.text,
      jumlah: _jumlahController.text,
      tanggalMasuk: _tanggalController.text,
      volume: _volumeController.text,
      penulis: _penulisController.text,
      penerbit: _penerbitController.text,
    );

    ProdukBloc.addProduk(produk: newProduk).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProdukPage()),
      );
    }).catchError((_) {
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(description: "Gagal menyimpan data"),
      );
    }).whenComplete(() => setState(() => _isLoading = false));
  }

  void ubah() {
    setState(() => _isLoading = true);

    Produk update = Produk(
      id: widget.produk!.id,
      judul: _judulController.text,
      harga: _hargaController.text,
      jumlah: _jumlahController.text,
      tanggalMasuk: _tanggalController.text,
      volume: _volumeController.text,
      penulis: _penulisController.text,
      penerbit: _penerbitController.text,
    );

    ProdukBloc.updateProduk(produk: update).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProdukPage()),
      );
    }).catchError((_) {
      showDialog(
        context: context,
        builder: (context) => const WarningDialog(description: "Gagal mengubah data"),
      );
    }).whenComplete(() => setState(() => _isLoading = false));
  }
}