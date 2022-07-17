import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/contact.dart';
import '../bloc/contact_bloc.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  State<AddContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<AddContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  ContactBloc get bloc => BlocProvider.of(context);
  Contact? _contact;

  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)!.settings.arguments as Contact?;

    final size = MediaQuery.of(context).size;

    if (contact != null) {
      _nameController
        ..text = contact.name
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: _nameController.text.length));
      _phoneNumberController
        ..text = contact.phoneNumber
        ..selection = TextSelection.fromPosition(
            TextPosition(offset: _phoneNumberController.text.length));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add Contact')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Name'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                label: Text('PhoneNumber'),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  _contact = Contact(
                    name: _nameController.text,
                    phoneNumber: _phoneNumberController.text,
                    id: contact?.id,
                  );
                  Navigator.pop(context, _contact);
                },
                child: Container(
                    width: size.width / 2,
                    height: size.height / 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.pink.shade200),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
