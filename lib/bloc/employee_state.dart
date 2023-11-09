import 'package:local_storage/models/employee_model.dart';

class EmployeeState {
  bool isLoading;
  List<Employee> employeeList;

  EmployeeState(
      {required this.isLoading,
        required this.employeeList});

  EmployeeState.defaultMode()
      : isLoading = true,
        employeeList = [];

  EmployeeState.copy(EmployeeState state)
      : isLoading = state.isLoading,
        employeeList = state.employeeList;

  EmployeeState copyWith(
      {bool? isLoading, List<Employee>? employeeList}) {
    return EmployeeState(
      isLoading: isLoading ?? this.isLoading,
        employeeList: employeeList ?? this.employeeList);
  }
}
