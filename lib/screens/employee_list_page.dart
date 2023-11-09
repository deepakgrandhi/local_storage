import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:local_storage/bloc/employee_actions.dart';
import 'package:local_storage/bloc/employee_bloc.dart';
import 'package:local_storage/bloc/employee_state.dart';
import 'package:local_storage/models/employee_model.dart';
import 'package:local_storage/screens/edit_employee.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<StatefulWidget> createState() => _EmployeeListPage();
}

class _EmployeeListPage extends State<EmployeeListPage> {
  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<EmployeeBloc>()) {
      GetIt.I.registerSingleton<EmployeeBloc>(
          EmployeeBloc(EmployeeState.defaultMode()));
    }
    GetIt.I<EmployeeBloc>().add(LoadEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Employee List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocProvider.value(
        value: GetIt.I<EmployeeBloc>(),
        child:
            BlocBuilder<EmployeeBloc, EmployeeState>(builder: (context, state) {
          return EmployeeList(
            state: state,
          );
        }),
      ),
    );
  }
}

class EmployeeList extends StatelessWidget {
  final EmployeeState state;

  const EmployeeList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentEmployees = state.employeeList
        .where((employee) => employee.endDate==0)
        .toList();

    final pastEmployees = state.employeeList
        .where((employee) => employee.endDate!=0)
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_employee");
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.employeeList.isEmpty
              ? Center(
            child: Image.asset("assets/no_data.png"),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: 2, // Two sections: Current and Past Employees
              itemBuilder: (context, sectionIndex) {
                List<Employee> employeesInSection = sectionIndex == 0
                    ? currentEmployees
                    : pastEmployees;

                return employeesInSection.isEmpty
                    ? const SizedBox.shrink() // Hide empty sections
                    : Column(
                  children: [
                    ListTile(
                      title: Text(
                        sectionIndex == 0
                            ? 'Current Employees'
                            : 'Past Employees',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: sectionIndex == 0
                              ? Colors.green // Customize colors as needed
                              : Colors.red,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: employeesInSection.length,
                      itemBuilder: (context, index) {
                        final employee = employeesInSection[index];
                        return Dismissible(
                          key: Key(employee.id.toString()),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child:
                            const Icon(Icons.delete, color: Colors.white),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            GetIt.I<EmployeeBloc>()
                                .add(DeleteEmployee(id: employee.id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${employee.name} deleted'),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              employee.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(employee.role),
                                Text(
                                    "From: ${DateFormat("dd MMM yyyy").format(employee.startDate)}"),
                                Text(employee.endDate != 0
                                    ? "To: ${DateFormat("dd MMM yyyy").format(
                                    DateTime.fromMillisecondsSinceEpoch(employee.endDate))}"
                                    : ""),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EmployeeEditPage(employee: employee),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}