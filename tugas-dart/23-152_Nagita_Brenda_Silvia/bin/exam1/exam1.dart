dynamic studentInfo() {
  // TODO 1: Isi variabel sesuai dengan instruksi
  var name = "Nagita Brenda Silvia"; 
  var favNumber = 7; 
  var isPraktikan = true;
  // End of TODO 1
  return [name, favNumber, isPraktikan];
}

double circleArea(num r) {
  // TODO 2: Perbaikan tipe data return
  if (r < 0) {
    return 0.0;
  }
  const double pi = 3.1415926535897932;
  return pi * r * r;
  // End of TODO 2
}

int? parseAndAddOne(String? input) {
  // TODO 3: Perbaikan konversi
  if (input == null) {
    return null;
  }
  try {
    return int.parse(input) + 1;
  } catch (e) {
    throw Exception('Input harus berupa angka');
  }
  // End of TODO 3
}
