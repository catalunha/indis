import 'package:flutter/material.dart';

class InfoDataEditDS extends StatefulWidget {
  final String code;
  final String description;
  final String uf;
  final String city;
  final String area;
  final bool isCreateOrUpdate;
  final Function(String, String, String, String, String) onCreate;
  final Function(String, String, String, String, String) onUpdate;

  const InfoDataEditDS({
    Key key,
    this.code,
    this.description,
    this.area,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.uf,
    this.city,
  }) : super(key: key);
  @override
  _InfoDataEditDSState createState() => _InfoDataEditDSState();
}

class _InfoDataEditDSState extends State<InfoDataEditDS> {
  final formKey = GlobalKey<FormState>();
  String _code;
  String _description;
  String _uf;
  String _city;
  String _area;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_uf, _city, _area, _code, _description)
          : widget.onUpdate(_uf, _city, _area, _code, _description);
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
        title: Text(widget.isCreateOrUpdate ? 'Criar dados' : 'Editar dados'),
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
        ],
      ),
    );
  }
}
