class Area {
  double? length;
  double? breadth;

  double calculateArea() {
    return length! * breadth!;
  }
}

void main() {
  var area = Area();
  area.length = 10;
  area.breadth = 5;

  print("Luas area: ${area.calculateArea()}");
}