part of 'contact_bloc.dart';

@immutable
abstract class ContactState {
  final List<Contact> contacts;

  ContactState(this.contacts);
}

class ContactsInitial extends ContactState {
  ContactsInitial(super.contacts);
}

class ContactsLoaded extends ContactState {
  ContactsLoaded(super.contacts);
}
