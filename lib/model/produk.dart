class Produk {
  String? id;
  String? judul;
  String? harga;
  String? jumlah;
  String? tanggalMasuk;
  String? volume;
  String? penulis;
  String? penerbit;

  Produk({
    this.id,
    this.judul,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.volume,
    this.penulis,
    this.penerbit,
  });

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'].toString(),
      judul: obj['judul'],
      harga: obj['harga'].toString(),
      jumlah: obj['jumlah'].toString(),
      tanggalMasuk: obj['tanggal_masuk'],
      volume: obj['volume'].toString(),
      penulis: obj['penulis'],
      penerbit: obj['penerbit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "judul": judul,
      "harga": harga,
      "jumlah": jumlah,
      "tanggal_masuk": tanggalMasuk,
      "volume": volume,
      "penulis": penulis,
      "penerbit": penerbit,
    };
  }
}