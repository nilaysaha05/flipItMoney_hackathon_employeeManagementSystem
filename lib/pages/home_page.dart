import 'package:employee_management_system/pages/form_page.dart';
import 'package:employee_management_system/pages/profile_page.dart';
import 'package:employee_management_system/widget/employee_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDescending = false;
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
      _empl = data.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    //print();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text('Employee Management System'),
        ),
      ),
      body: _empl.isEmpty
          ? const Center(
              child: Text(
                'Press + to add employee data..',
                style: TextStyle(fontSize: 15),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isDescending = !isDescending;
                    });
                  },
                  icon: RotatedBox(
                    quarterTurns: 1,
                    child: isDescending
                        ? const Icon(
                            Icons.arrow_right_rounded,
                            size: 25,
                          )
                        : const Icon(
                            Icons.arrow_left_rounded,
                            size: 30,
                          ),
                  ),
                  label: const Text(
                    'Sort by Name',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Employee List',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                      itemCount: _empl.length,
                      itemBuilder: (_, i) {
                        final sortedList = _empl
                          ..sort((a, b) {
                            String textA = a['name'].toUpperCase();
                            String textB = b['name'].toUpperCase();
                            return isDescending
                                ? textB.compareTo(textA)
                                : textA.compareTo(textB);
                          });
                        final currentItem = sortedList[i];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                        );
                      }),
                ),
              ],
            ),
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
