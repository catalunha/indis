import 'package:flutter/material.dart';
import 'package:indis/conectors/info_ind_owner/info_ind_owner_select.dart';
import 'package:indis/models/info_ind_owner_model.dart';

class InfoCodeEditDS extends StatefulWidget {
  final String code;
  final String description;
  final String name;
  final String unit;
  final InfoIndOwnerModel infoIndOwnerRef;

  final bool arquived;
  final bool isCreateOrUpdate;
  final Function(String, String, String, String) onCreate;
  final Function(String, String, String, String, bool) onUpdate;

  const InfoCodeEditDS({
    Key key,
    this.code,
    this.name,
    this.unit,
    this.infoIndOwnerRef,
    this.description,
    this.arquived,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _InfoCodeEditDSState createState() => _InfoCodeEditDSState();
}

class _InfoCodeEditDSState extends State<InfoCodeEditDS> {
  final formKey = GlobalKey<FormState>();
  String _code;
  String _description;
  String _name;
  String _unit;
  bool _arquived;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_code, _description, _name, _unit)
          : widget.onUpdate(_code, _description, _name, _unit, _arquived);
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
        title: Text(
            widget.isCreateOrUpdate ? 'Criar informação' : 'Editar informação'),
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
              labelText: 'Codigo da informação',
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
              labelText: 'Nome da informação',
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
              labelText: 'Descrição da informação',
            ),
            onSaved: (newValue) => _description = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: widget.unit,
            decoration: InputDecoration(
              labelText: 'Unidade da informação',
            ),
            onSaved: (newValue) => _unit = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          ListTile(
            title: Text('${widget.infoIndOwnerRef?.name}'),
            subtitle: Text('Qual o proprietário desta informação.'),
            trailing: Icon(Icons.search),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => InfoindOwnerSelect(),
              );
            },
          ),
          widget.isCreateOrUpdate
              ? Container()
              : SwitchListTile(
                  value: _arquived,
                  title: Text('Arquivar informação'),
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
