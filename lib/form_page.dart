import 'package:employee_management_system/helpers.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _graduationYearController =
  TextEditingController();
  String jokes ='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJoke();
  }


  Future getJoke()async{
    Helpers helpers = Helpers();
    String _joke = await helpers.getDadJoke();
    setState(() {
      jokes = _joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(jokes),
          ),
        ),
        body:SafeArea(
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
                        backgroundImage: CachedNetworkImageProvider(Helpers.randomPictureUrl()) ,
                      ),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: "JOB-ID", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: "Full Name", border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        hintText: "Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: "Department",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      maxLines: 1,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Salary",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0.0),
                        onPressed: () {},
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
        ),);
  }
}
