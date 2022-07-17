import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/contact.dart';
import '../interactor/impl/interactor.impl.dart';
import '../repository/repository.impl.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final InteractorImpl _interactor = InteractorImpl(RepositoryImpl());

  ContactBloc() : super(ContactsInitial(const <Contact>[])) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    final contacts = _interactor.loadContact();
    emit(ContactsLoaded(contacts));
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactState> emit,
  ) async {
    final contacts = state.contacts..add(event.contact);
    emit(ContactsLoaded(contacts));
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<ContactState> emit,
  ) async {
    final newContacts = state.contacts;
    newContacts[state.contacts
            .indexWhere((element) => element.id == event.contact.id)] =
        event.contact;
    emit(ContactsLoaded(newContacts));
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<ContactState> emit,
  ) async {
    final newContacts = state.contacts..remove(event.contact);
    emit(ContactsLoaded(newContacts));
  }
}
