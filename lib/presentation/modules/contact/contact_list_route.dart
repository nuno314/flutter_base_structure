import 'package:flutter/material.dart';

import '../../models/contact.dart';
import '../../route/route_list.dart';
import 'views/add_contact_screen.dart';
import 'views/contact_list_screen.dart';
import 'views/detail_contact_screen.dart';

class ContactListRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.contact: (context) => const ContactListScreen(),
        RouteList.addContact: (context) => const AddContactScreen(),
        RouteList.detailContact: (context) =>
            DetailContactScreen(contact: settings.arguments as Contact),
      };
}
