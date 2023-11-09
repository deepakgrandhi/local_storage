import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:local_storage/bloc/employee_actions.dart';
import 'package:local_storage/bloc/employee_bloc.dart';
import 'package:local_storage/models/employee_model.dart';
import 'package:local_storage/widgets/date_picker.dart';

class EmployeeAddPage extends StatefulWidget {
  const EmployeeAddPage({super.key});

  @override
  State<EmployeeAddPage> createState() => _EmployeeAddPageState();
}

class _EmployeeAddPageState extends State<EmployeeAddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  DateTime startDate = DateTime.now();
  String endDate = "";
  List<String> roles = [
    'Product designer',
    'Flutter developer',
    'QA tester',
    'Product owner'
  ];
  String selectedRole = "";

  @override
  void initState() {
    super.initState();
    selectedRole = roles.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Employee Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedRole,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
                items: roles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Role'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Start Date'),
                      subtitle:
                          Text(DateFormat("dd MMM yyyy").format(startDate)),
                      onTap: () async {
                        await DatePickerCustom()
                            .showStartDatePicker(context)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              startDate = value;
                            });
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('End Date'),
                      subtitle: Text(endDate.isNotEmpty
                          ? DateFormat("dd MMM yyyy")
                              .format(DateTime.parse(endDate))
                          : "-"),
                      onTap: () async {
                        await DatePickerCustom()
                            .showEndDatePicker(context)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              endDate = value.toString();
                            });
                          } else {
                            endDate = "";
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newEmployee = Employee(
                          name: nameController.text,
                          role: selectedRole,
                          startDate: startDate,
                          endDate: endDate.isNotEmpty
                              ? DateTime.parse(endDate).millisecondsSinceEpoch
                              : 0,
                          id: DateTime.now().millisecondsSinceEpoch,
                        );

                        GetIt.I<EmployeeBloc>()
                            .add(AddEmployee(employee: newEmployee));
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
