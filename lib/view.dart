import 'package:blahblah/controller.dart';
import 'package:flutter/material.dart';

class EnterData extends StatefulWidget {
  const EnterData({super.key});

  @override
  State<EnterData> createState() => _EnterDataState();
}

class _EnterDataState extends State<EnterData> {
  final HiveController hiveController = HiveController();

  List<TextEditingController> controllers =
      List.generate(3, (_) => TextEditingController());

  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              hiveTextFormField(
                  textController: controllers[0], title: 'Username'),
              hiveTextFormField(textController: controllers[1], title: 'Email'),
              hiveTextFormField(
                  textController: controllers[2], title: 'Password'),
              ElevatedButton(
                onPressed: () {
                  if (controllers
                      .every((controller) => controller.text.isEmpty)) {
                    snackMessenger(message: 'Data is Empty');
                  } else {
                    setState(() {
                      username = controllers[0].text;
                      email = controllers[1].text;
                      password = controllers[2].text;

                      for (var controller in controllers) {
                        controller.clear();
                      }
                      snackMessenger(
                        message: 'User Details Successfully Added',
                      );
                    });
                  }
                },
                child: const Text('Save Data'),
              ),
              const SizedBox(height: 20),
              if (username != null && email != null && password != null)
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Username : $username',
                            style: const TextStyle(fontSize: 16)),
                        Text('Email : $email',
                            style: const TextStyle(fontSize: 16)),
                        Text('Password : $password',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  if (username == null && email == null && password == null) {
                    snackMessenger(message: 'Nothing to Delete');
                  } else {
                    setState(() {
                      hiveController.deleteData();
                      username = null;
                      email = null;
                      password = null;
                    });
                    snackMessenger(
                        message: 'User Details Successfully Deleted');
                  }
                },
                child: const Text('Delete Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding hiveTextFormField(
      {required TextEditingController textController, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          labelText: title,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  void snackMessenger({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.all(16.0),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      content: Text(message),
    ));
  }
}
