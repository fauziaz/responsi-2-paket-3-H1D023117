import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/bloc/logout_bloc.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/bloc/produk_bloc.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/model/produk.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/login_page.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_detail.dart';
import 'package:responsi_2_mobile_paket_3_h1d023117/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final Color primary = const Color(0xFF4B382A);
  final bg = const Color(0xFFF8F3ED);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Inventaris Buku Fauziamart',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),

      drawer: buildCustomDrawer(context),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProdukForm()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: FutureBuilder<List<Produk>>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListProduk(list: snapshot.data!)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


  Drawer buildCustomDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfff8f3ed),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Color(0xFF4B382A)),
                ),
                SizedBox(height: 12),
                Text(
                  "Inventaris Fauziamart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "H1D023117",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _drawerItem(
                  icon: Icons.library_books,
                  title: "Daftar Buku",
                  primary: primary,
                  onTap: () => Navigator.pop(context),
                ),
                _drawerItem(
                  icon: Icons.add_box,
                  title: "Tambah Buku",
                  primary: primary,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProdukForm()),
                    );
                  },
                ),
                _drawerItem(
                  icon: Icons.info_outline,
                  title: "Tentang Aplikasi",
                  primary: primary,
                  onTap: () {
                    Navigator.pop(context);

                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      backgroundColor: Colors.white,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.menu_book_rounded, size: 56, color: primary),
                                    const SizedBox(height: 12),
                                    Text(
                                      "Fauziamart Inventaris Buku",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      "Versi 1.0.0",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),
                              Divider(thickness: 1),

                              const SizedBox(height: 12),
                              Text(
                                "Tentang Aplikasi",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Aplikasi inventaris buku Responsi 2 Paket 3 - H1D023117.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Tutup",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primary,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),
                Divider(color: primary.withOpacity(0.3)),
                const SizedBox(height: 10),

                _drawerItem(
                  icon: Icons.logout,
                  title: "Logout",
                  primary: Colors.red,
                  iconColor: Colors.red,
                  onTap: () async {
                    await LogoutBloc.logout().then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required Color primary,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: iconColor ?? primary,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List<Produk> list;

  const ListProduk({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: list.length,
      itemBuilder: (context, i) => ItemProduk(produk: list[i]),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({super.key, required this.produk});

  Color get primary => const Color(0xFF4B382A);

  @override
  Widget build(BuildContext context) {
    String initial = (produk.judul != null && produk.judul!.isNotEmpty)
        ? produk.judul![0].toUpperCase()
        : '?';

    final intJumlah = (() {
      try {
        if (produk.jumlah == null) return 1;
        if (produk.jumlah is int) return produk.jumlah as int;
        return int.tryParse(produk.jumlah.toString()) ?? 1;
      } catch (_) {
        return 1;
      }
    })();

    final ratingString = "4.${((intJumlah % 5) + 1)}";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [

              Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6E4F37), Color(0xFF4B382A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk.judul ?? "-",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text("Penulis: ${produk.penulis ?? '-'}",
                        style: const TextStyle(fontSize: 14)),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        _buildChip("Rp ${produk.harga ?? '-'}"),
                        const SizedBox(width: 6),
                        _buildChip("Qty: ${produk.jumlah ?? '-'}"),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(Icons.star, size: 18, color: Colors.amber.shade600),
                        const SizedBox(width: 6),
                        Text(
                          ratingString,
                          style: TextStyle(
                            fontSize: 14,
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xfff3ebe3),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}