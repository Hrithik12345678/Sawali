import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sawali/Auth/contactmanager.dart';
import 'package:sawali/Screens/search.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> with AutomaticKeepAliveClientMixin {
  List<ContactList> contact = [];
  List<ContactList> contactdisplay = [];
  String query = '';
  int len = 0;
  TextEditingController searchController = new TextEditingController();

  Map<String, String> contactMap = {};

  void searchContact(String query) {
    setState(() {
      this.query = query;
      contactdisplay = contact.where((element) {
        final titleLower = element.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      var contacts = (await ContactsService.getContacts(
        withThumbnails: false,
        photoHighResolution: false,
      ))
          .toList();
      for (int i = 0; i < contacts.length; i++) {
        setState(() {
          contactMap[contacts[i].displayName.toString()] =
              (contacts[i].phones!.isNotEmpty
                      ? contacts[i].phones!.first.value
                      : '(none)')
                  .toString();
          len = contacts.length;
        });
      }
      setState(() {
        contactMap.forEach((k, v) => contact.add(ContactList(k, v)));
      });
    } else {
      print("invalid permission");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 33, 71, 0.9),
                Color.fromRGBO(0, 33, 71, 0.8)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SearchWidget(
                        text: query,
                        onChanged: searchContact,
                        hintText: "Search",
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height,
                        minWidth: MediaQuery.of(context).size.width),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: query.isNotEmpty
                            ? contactdisplay.length
                            : contact.length,
                        itemBuilder: (BuildContext context, int index) {
                          ContactList item = query.isNotEmpty
                              ? contactdisplay[index]
                              : contact[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                item.name[0],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  print(item.name);
                                  print(item.cell);
                                  addContact(item.name, item.cell);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            title: Text(
                              item.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              item.cell,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ContactList {
  final String name;
  final String cell;
  ContactList(this.name, this.cell);

  @override
  String toString() {
    return ' ${this.name}, ${this.cell} ';
  }
}
