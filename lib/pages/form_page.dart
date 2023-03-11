import 'package:employee_management_system/helpers.dart';
import 'package:employee_management_system/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jobIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _deptController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final _employeeBox = Hive.box('employee');
  String jokes = '';
  String photoUrl = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJoke();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _jobIdController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _deptController.dispose();
    _salaryController.dispose();
  }

  Future<void> _createEmp(Map<String, dynamic> newEmp) async {
    await _employeeBox.add(newEmp);
  }

  Future getJoke() async {
    Helpers helpers = Helpers();
    String joke = await helpers.getDadJoke();
    setState(() {
      jokes = joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    photoUrl = Helpers.randomPictureUrl();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee Data'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 64.0,
                      backgroundImage: CachedNetworkImageProvider(
                        photoUrl,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    controller: _jobIdController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: TextButton(
                        onPressed: () {
                          final id = Helpers.generateRandomString(6);

                          _jobIdController.text = id;
                        },
                        child: const Text('Get Id'),
                      ),
                      labelText: 'JOB-ID',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[a-z A-Z \d]+$').hasMatch(value!))
                      {
                        return "Enter correct id";

                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _nameController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[a-z A-Z ]+$').hasMatch(value!))
                      {
                        return "Enter correct name";

                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _addressController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty )
                      {
                        return "Enter correct address";

                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _deptController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: "Dept.",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[a-z A-Z ]+$').hasMatch(value!))
                      {
                        return "Enter correct dept name";

                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _salaryController,
                    maxLines: 1,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Salary",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[ \d]+$').hasMatch(value!))
                      {
                        return "Enter correct amount";

                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0.0),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Helpers().showSnackBar('Submitting Data', context);
                          _createEmp({
                            'jobId': _jobIdController.text,
                            'name': _nameController.text,
                            'address': _addressController.text,
                            'dept': _deptController.text,
                            'bioJoke': jokes,
                            'salary': _salaryController.text,
                            'photoUrl': photoUrl,
                          });
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: const Text('Save Data'),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
