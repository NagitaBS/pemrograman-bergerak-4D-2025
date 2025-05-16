<?php
header("Content-Type: application/json");
include 'koneksi.php';

// Ambil input JSON
$input = json_decode(file_get_contents("php://input"), true);

$Judul_Buku = $input['Judul_Buku'] ?? '';
$Penulis = $input['Penulis'] ?? '';
$Genre = $input['Genre'] ?? '';
$Tahun_Terbit = $input['Tahun_Terbit'] ?? '';
$Deskripsi = $input['Deskripsi'] ?? '';


// Validasi Tahun Terbit
if (!is_numeric($Tahun_Terbit) || $Tahun_Terbit == '') {
    echo json_encode([
        "status" => "error",
        "message" => "Tahun Terbit harus berupa angka dan tidak boleh kosong"
    ]);
    exit;
}

// Query insert
$sql = "INSERT INTO buku (`Judul_Buku`, `Penulis`, `Genre`, `Tahun_Terbit`, `Deskripsi`)
        VALUES ('$Judul_Buku', '$Penulis', '$Genre', '$Tahun_Terbit', '$Deskripsi')";

if (mysqli_query($conn, $sql)) {
    echo json_encode([
        "status" => "success",
        "message" => "Data berhasil ditambahkan"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Gagal menambahkan data: " . mysqli_error($conn)
    ]);
}
?>
