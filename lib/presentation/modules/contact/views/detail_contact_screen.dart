import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/contact.dart';
import '../../../route/route_list.dart';
import '../bloc/contact_bloc.dart';

class DetailContactScreen extends StatefulWidget {
  final Contact contact;

  const DetailContactScreen({super.key, required this.contact});
  @override
  State<DetailContactScreen> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactScreen> {
  Contact? _contact;
  @override
  void initState() {
    _contact = widget.contact;
    super.initState();
  }

  ContactBloc get bloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _contact);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: Column(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: CircleAvatar(
                radius: size.width / 10,
                backgroundColor: Colors.pink,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                _contact!.name,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                _contact!.phoneNumber,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  final newContact = await Navigator.pushNamed(
                      context, RouteList.addContact,
                      arguments: _contact!);

                  if (newContact is Contact && newContact != widget.contact) {
                    setState(() {
                      _contact = newContact;
                    });
                  }
                },
                child: Container(
                    width: size.width / 2.5,
                    height: size.height / 15,
                    decoration: BoxDecoration(color: Colors.green.shade700),
                    child: const Center(
                        child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, null);
                },
                child: Container(
                    width: size.width / 2.5,
                    height: size.height / 15,
                    decoration: BoxDecoration(color: Colors.red.shade700),
                    child: const Center(
                        child: Text(
                      'Remove',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
