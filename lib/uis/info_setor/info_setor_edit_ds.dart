import 'package:flutter/material.dart';

class InfoSetorEditDS extends StatefulWidget {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final bool public;
  final bool isCreateOrUpdate;
  final Function(String, String, String, String, String, bool) onCreate;
  final Function(String, String, String, String, String, bool) onUpdate;

  const InfoSetorEditDS({
    Key key,
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.public,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _InfoSetorEditDSState createState() => _InfoSetorEditDSState();
}

class _InfoSetorEditDSState extends State<InfoSetorEditDS> {
  final formKey = GlobalKey<FormState>();
  String _uf;
  String _city;
  String _area;
  String _code;
  String _description;
  bool _public;
  void validateSetor() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_uf, _city, _area, _code, _description, _public)
          : widget.onUpdate(_uf, _city, _area, _code, _description, _public);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _public = widget.public;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreateOrUpdate ? 'Criar dados' : 'Editar dados'),
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
            initialValue: widget.uf,
            decoration: InputDecoration(
              labelText: 'Estado',
            ),
            onSaved: (newValue) => _uf = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.city,
            decoration: InputDecoration(
              labelText: 'Cidade',
            ),
            onSaved: (newValue) => _city = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.area,
            decoration: InputDecoration(
              labelText: 'Area',
            ),
            onSaved: (newValue) => _area = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.code,
            decoration: InputDecoration(
              labelText: 'Codigo da área',
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
            initialValue: widget.description,
            decoration: InputDecoration(
              labelText: 'Descrição da área',
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
            value: _public,
            title: Text('Área pública ? Todos poderão cooperar.'),
            onChanged: (value) {
              setState(() {
                _public = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
