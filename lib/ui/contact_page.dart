import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;
  const ContactPage({super.key, this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact? _editedContact;
  ContactHelper _contactHelper = ContactHelper();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _edited = false;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());
    }

    _nameController.text = _editedContact!.name ?? "";
    _emailController.text = _editedContact!.email ?? "";
    _phoneController.text = _editedContact!.phone ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          _editedContact!.name.isNotEmpty
              ? _editedContact!.name
              : "Novo Contato",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _contactHelper.saveContact(_editedContact!),
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact!.img != null &&
                            _editedContact!.img!.isNotEmpty
                        ? FileImage(File(_editedContact!.img!))
                        : const AssetImage("images/person.png")
                            as ImageProvider,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                setState(() {
                  _editedContact!.name = text;
                  _edited = true;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: (text) {
                _editedContact!.email = text;
                _edited = true;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              onChanged: (text) {
                _editedContact!.phone = text;
                _edited = true;
              },
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
