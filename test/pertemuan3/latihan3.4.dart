class Student {
  String? name;
  int? age;
  int? grade;

  void displayInfo() {
    print("Student name: $name.");
    print("Student age: $age.");
    print("Student grade: $grade.");
  }
}

void main() {
  var student = Student();
  student.name = "Andi";
  student.age = 18;
  student.grade = 12;

  student.displayInfo();
}