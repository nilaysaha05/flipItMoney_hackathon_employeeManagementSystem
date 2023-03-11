import 'package:employee_management_system/pages/form_page.dart';
import 'package:employee_management_system/pages/profile_page.dart';
import 'package:employee_management_system/pages/widget/employee_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _employeeBox = Hive.box('employee');
  List<Map<String, dynamic>> _empl = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  void _refresh() {
    final data = _employeeBox.keys.map((key) {
      final item = _employeeBox.get(key);
      return {
        'key': key,
        'jobId': item['jobId'],
        'name': item['name'],
        'address': item['address'],
        'dept': item['dept'],
        'bioJoke': item['bioJoke'],
        'salary': item['salary'],
        'photoUrl': item['photoUrl'],
      };
    }).toList();
    setState(() {
      _empl = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Employee Management System'),
        ),
      ),
      body: ListView.builder(
          itemCount: _empl.length,
          itemBuilder: (_, i) {
            final currentItem = _empl[i];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    EmployeeTile(
                      photoUrl: currentItem['photoUrl'],
                      jobId: currentItem['jobId'],
                      name: currentItem['name'],
                      bioJoke: currentItem['bioJoke'],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              currentItem['name'],
                              currentItem['jobId'],
                              currentItem['bioJoke'],
                              currentItem['salary'],
                              currentItem['dept'],
                              currentItem['address'],
                              currentItem['photoUrl'],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add data'),
        icon: const Icon(Icons.add_rounded),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FormPage(),
            ),
          );
        },
      ),
    );
  }
}
