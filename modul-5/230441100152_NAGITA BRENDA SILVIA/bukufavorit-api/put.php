<?php
header("Content-Type: application/json");
include 'koneksi.php';

// Ambil input JSON
$data = json_decode(file_get_contents("php://input"), true);

// Ambil dan validasi data
$id = $data['id'] ?? '';
$Judul_Buku = $data['Judul_Buku'] ?? '';
$Penulis = $data['Penulis'] ?? '';
$Genre = $data['Genre'] ?? '';
$Tahun_Terbit = $data['Tahun_Terbit'] ?? '';
$Deskripsi = $data['Deskripsi'] ?? '';

if ($id == '' || $Judul_Buku == '' || $Penulis == '' || $Genre == '' || $Tahun_Terbit == '') {
    echo json_encode([
        "status" => "error",
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

// Sesuaikan dengan nama kolom di database
$query = "UPDATE buku SET 
            `Judul_Buku`='$Judul_Buku',
            `Penulis`='$Penulis',
            `Genre`='$Genre',
            `Tahun_Terbit`='$Tahun_Terbit',
            `Deskripsi`='$Deskripsi'
          WHERE id=$id";

if (mysqli_query($conn, $query)) {
    echo json_encode(["status" => "success", "message" => "Buku berhasil diupdate"]);
} else {
    echo json_encode(["status" => "error", "message" => "Gagal update buku: " . mysqli_error($conn)]);
}
?>
