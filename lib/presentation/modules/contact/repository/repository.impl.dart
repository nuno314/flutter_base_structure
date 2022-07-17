import 'package:flutterbasestructure/presentation/models/contact.dart';

import '../interactor/repository.dart';

class RepositoryImpl extends Repository {
  @override
  List<Contact> loadContact() {
    return [
      Contact(name: 'Tin', phoneNumber: '0336948000', id: 0),
      Contact(name: 'Lam', phoneNumber: '0336948001', id: 1),
      Contact(name: 'Van', phoneNumber: '0336948002', id: 2),
    ];
  }


}
