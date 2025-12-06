import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/bloc/produk_bloc.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/model/produk.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_form.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_page.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  const ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukDetail> createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  final Color primary = const Color(0xFF4B382A);
  final Color bg = const Color(0xFFF8F3ED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          "Detail Buku",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _headerCard(),

            const SizedBox(height: 20),

            _detailCard("Judul", widget.produk!.judul),
            _detailCard("Penulis", widget.produk!.penulis),
            _detailCard("Penerbit", widget.produk!.penerbit),
            _detailCard("Harga", "Rp ${widget.produk!.harga}"),
            _detailCard("Jumlah", widget.produk!.jumlah.toString()),
            _detailCard("Volume", widget.produk!.volume),
            _detailCard("Tanggal Masuk", widget.produk!.tanggalMasuk),

            const SizedBox(height: 25),

            _buttonAction(),
          ],
        ),
      ),
    );
  }

  Widget _headerCard() {
    String initial = widget.produk!.judul!.isNotEmpty
        ? widget.produk!.judul![0].toUpperCase()
        : "?";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6E4F37), Color(0xFF4B382A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 85,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.produk!.judul ?? "-",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _detailCard(String label, dynamic value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label : ",
            style: TextStyle(
              fontSize: 15,
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? "-",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonAction() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFF6E4F37),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("EDIT",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProdukForm(produk: widget.produk!),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text("DELETE",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: confirmDelete,
          ),
        ),
      ],
    );
  }

  void confirmDelete() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F3ED),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ICON WARNING ELEGAN
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B382A).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFF4B382A),
                    size: 50,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Hapus Buku?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B382A),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Apakah kamu yakin ingin menghapus buku ini? Data yang sudah dihapus tidak bisa dikembalikan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6E4F37),
                  ),
                ),

                const SizedBox(height: 22),

                // TOMBOL DELETE
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Hapus",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!))
                          .then(
                        (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const ProdukPage()),
                          (route) => false,
                        ),
                      ).onError((error, _) {
                        showDialog(
                          context: context,
                          builder: (context) => const WarningDialog(
                            description: "Hapus gagal, silahkan coba lagi",
                          ),
                        );
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // TOMBOL BATAL
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: const Color(0xFF4B382A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Batal",
                      style: TextStyle(
                        color: Color(0xFF4B382A),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}