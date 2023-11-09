class Employee {
  final int id;
  final String name;
  final String role;
  final DateTime startDate;
  final int endDate;

  Employee(
      {required this.id,
        required this.name,
        required this.role,
        required this.startDate,
        required this.endDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate,
    };
  }
}
