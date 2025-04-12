dynamic oddOrEven(int number) {
  // TODO 1: Mengecek bilangan ganjil/genap
  return (number % 2 == 0) ? "Genap" : "Ganjil";
  // End of TODO 1
}

dynamic createListOneToX(int x) {
  final List<int> list = [];

  // TODO 2: Membuat list dari 1 hingga x
  if (x > 0) {
    for (int i = 1; i <= x; i++) {
      list.add(i);
    }
  }
  // End of TODO 2

  return list;
}

String getStars(int n) {
  var result = '';

  // TODO 3: Membuat pola segitiga terbalik
  for (int i = n; i > 0; i--) {
    result += '*' * i + '\n';
  }
  // End of TODO 3

  return result;
}
