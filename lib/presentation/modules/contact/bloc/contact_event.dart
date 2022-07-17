part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact);
}

class UpdateContact extends ContactEvent {
  final Contact contact;

  UpdateContact(this.contact);
}

class DeleteContact extends ContactEvent {
  final Contact contact;

  DeleteContact(this.contact);
}
