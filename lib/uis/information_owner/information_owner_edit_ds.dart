import 'package:flutter/material.dart';

class InformationOwnerEditDS extends StatefulWidget {
  final String code;
  final String description;
  final String name;
  final bool arquived;
  final bool isCreateOrUpdate;
  final Function(String, String, String) onCreate;
  final Function(String, String, String, bool) onUpdate;

  const InformationOwnerEditDS({
    Key key,
    this.code,
    this.description,
    this.arquived,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.name,
  }) : super(key: key);
  @override
  _InformationOwnerEditDSState createState() => _InformationOwnerEditDSState();
}

class _InformationOwnerEditDSState extends State<InformationOwnerEditDS> {
  final formKey = GlobalKey<FormState>();
  String _code;
  String _description;
  String _name;
  bool _arquived;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_code, _description, _name)
          : widget.onUpdate(_code, _description, _name, _arquived);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _arquived = widget.arquived;
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
            initialValue: widget.code,
            decoration: InputDecoration(
              labelText: 'Codigo do proprietário das infos/ind',
            ),
            onSaved: (newValue) => _code = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.name,
            decoration: InputDecoration(
              labelText: 'Nome do proprietário das infos/ind',
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
              labelText: 'Descrição do proprietário das infos/ind',
            ),
            onSaved: (newValue) => _description = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _arquived,
                  title: Text('Arquivar proprietário'),
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
