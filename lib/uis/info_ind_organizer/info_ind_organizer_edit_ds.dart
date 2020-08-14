import 'package:flutter/material.dart';

class InfoIndOrganizerEditDS extends StatefulWidget {
  final String description;
  final String name;
  final bool isCreateOrUpdate;
  final Function(String, String) onCreate;
  final Function(String, String) onUpdate;

  const InfoIndOrganizerEditDS({
    Key key,
    this.description,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.name,
  }) : super(key: key);
  @override
  _InfoIndOrganizerEditDSState createState() => _InfoIndOrganizerEditDSState();
}

class _InfoIndOrganizerEditDSState extends State<InfoIndOrganizerEditDS> {
  final formKey = GlobalKey<FormState>();
  String _description;
  String _name;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_name, _description)
          : widget.onUpdate(_name, _description);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreateOrUpdate
            ? 'Criar proprietário'
            : 'Editar proprietário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          validateData();
        },
      ),
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            initialValue: widget.name,
            decoration: InputDecoration(
              labelText: 'Nome do organizador das infos/ind',
            ),
            onSaved: (newValue) => _name = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.description,
            decoration: InputDecoration(
              labelText: 'Descrição do organizador das infos/ind',
            ),
            onSaved: (newValue) => _description = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
