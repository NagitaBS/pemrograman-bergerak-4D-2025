<?php
header("Content-Type: application/json");
include 'koneksi.php';

// Ambil input JSON
$input = json_decode(file_get_contents("php://input"), true);

// Validasi ID
$id = $input['id'] ?? '';
if ($id === '' || !is_numeric($id)) {
    echo json_encode([
        "status" => "error",
        "message" => "ID tidak valid atau tidak dikirim"
    ]);
    exit;
}

// Jalankan query DELETE
$sql = "DELETE FROM buku WHERE id = $id";
if (mysqli_query($conn, $sql)) {
    echo json_encode([
        "status" => "success",
        "message" => "Data berhasil dihapus"
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Gagal menghapus data: " . mysqli_error($conn)
    ]);
}
?>
