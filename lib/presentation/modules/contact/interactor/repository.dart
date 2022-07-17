import '../../../models/contact.dart';

abstract class Repository {
  List<Contact> loadContact();
}
