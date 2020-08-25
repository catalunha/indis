import 'package:flutter/material.dart';

class InfoSetorSourceEditDS extends StatefulWidget {
  final String name;
  final String description;
  final bool isCreateOrUpdate;
  final Function(String, String, bool) onCreate;
  final Function(String, String, bool) onUpdate;

  const InfoSetorSourceEditDS({
    Key key,
    this.name,
    this.description,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _InfoSetorSourceEditDSState createState() => _InfoSetorSourceEditDSState();
}

class _InfoSetorSourceEditDSState extends State<InfoSetorSourceEditDS> {
  final formKey = GlobalKey<FormState>();

  String _name;
  String _description;
  bool _arquived = false;
  void validateSetor() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_name, _description, _arquived)
          : widget.onUpdate(_name, _description, _arquived);
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
        title: Text(widget.isCreateOrUpdate ? 'Criar fonte' : 'Editar fonte'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          validateSetor();
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
              labelText: 'Nome da fonte',
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
              labelText: 'Descrição da fonte',
            ),
            onSaved: (newValue) => _description = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          SwitchListTile(
            value: _arquived,
            title: Text('Arquivar esta fonte ?'),
            onChanged: (value) {
              setState(() {
                _arquived = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
