import '../../../../models/contact.dart';
import '../repository.dart';
import '../interactor.dart';

class InteractorImpl extends Interactor {
  final Repository repository;

  InteractorImpl(this.repository);

  @override
  List<Contact> loadContact() {
    return repository.loadContact();
  }
}
