import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbasestructure/presentation/modules/contact/bloc/contact_bloc.dart';

import '../../../models/contact.dart';
import '../../../route/route_list.dart';
import 'add_contact_screen.dart';
import 'detail_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  ContactBloc get bloc => BlocProvider.of(context);
  @override
  void initState() {
    bloc.add(LoadContacts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Contact List')),
        floatingActionButton: InkWell(
          onTap: () async {
            final contact =
                await Navigator.of(context).pushNamed(RouteList.addContact);

            if (contact is Contact) {
              bloc.add(AddContact(contact));
            }
          },
          child: const Icon(
            Icons.add,
            size: 100,
            color: Colors.pink,
          ),
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
          bloc: bloc,
          builder: (context, state) {
            final contacts = state.contacts;

            if (state is ContactsInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                  strokeWidth: 15,
                ),
              );
            } else if (state is ContactsLoaded) {
              return ListView(
                children: contacts
                    .map((contact) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: () async {
                              final updatedContact = await Navigator.pushNamed(
                                  context, RouteList.detailContact,
                                  arguments: contact);

                              // Update
                              if (updatedContact is Contact &&
                                  updatedContact != contact) {
                                bloc.add(UpdateContact(updatedContact));
                              }

                              // Remove
                              else if (updatedContact == null) {
                                bloc.add(DeleteContact(contact));
                              }
                            },
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.pink,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      contact.phoneNumber,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              );
            } else {
              return const Text('Error');
            }
          },
        ));
  }
}
