import 'package:local_storage/models/employee_model.dart';

abstract class EmployeeActions {}

class LoadEmployees extends EmployeeActions {}

class AddEmployee extends EmployeeActions {
  final Employee employee;

  AddEmployee({required this.employee});
}

class UpdateEmployee extends EmployeeActions {
  final Employee employee;

  UpdateEmployee({required this.employee});
}

class DeleteEmployee extends EmployeeActions {
  final int id;

  DeleteEmployee({required this.id});
}
