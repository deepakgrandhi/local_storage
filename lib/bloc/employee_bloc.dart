import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/bloc/employee_actions.dart';
import 'package:local_storage/bloc/employee_state.dart';
import 'package:local_storage/models/db_helper.dart';
import 'package:local_storage/models/employee_model.dart';

class EmployeeBloc extends Bloc<EmployeeActions, EmployeeState> {
  EmployeeBloc(EmployeeState initialState) : super(initialState) {
    on<LoadEmployees>((event, emit) async {
      final list = await getEmployees();
      emit(state.copyWith(
        employeeList: list,
        isLoading: false
      ));
    });

    on<AddEmployee>((event, emit){
      DatabaseHelper().insertEmployee(event.employee).then((value) {
        add(LoadEmployees());
      });
    });

    on<UpdateEmployee>((event, emit){
      DatabaseHelper().updateEmployee(event.employee).then((value) {
        add(LoadEmployees());
      });
    });

    on<DeleteEmployee>((event, emit){
      emit(state.copyWith(
        isLoading: true
      ));
      DatabaseHelper().deleteEmployee(event.id).then((value) {
        add(LoadEmployees());
        emit(state.copyWith(
            isLoading: false
        ));
      });
    });
  }

  Future<List<Employee>> getEmployees() async {
    final list = await DatabaseHelper().getEmployees();
    return list;
  }
}