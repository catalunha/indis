import 'package:flutter/material.dart';
import 'package:indis/conectors/info_code/info_code_select_to_infosetorvalue.dart';
import 'package:indis/conectors/user/user_select_to_infosetor.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/models/user_model.dart';

class InfoSetorEditDS extends StatefulWidget {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final bool public;
  final Map<String, UserModel> editorsMap;
  final Map<String, ValueInfo> valueMap;
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
    this.editorsMap,
    this.valueMap,
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
            title: Text(
                'Área pública ? Todos os usuários poderão cooperar com informações.'),
            onChanged: (value) {
              setState(() {
                _public = value;
              });
            },
          ),
          !_public
              ? ListTile(
                  title: Text(
                      'Há ${(widget.editorsMap != null && widget.editorsMap.isNotEmpty) ? widget.editorsMap.length : null} usuários cooperando com informações.'),
                  leading: Icon(Icons.search),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => UserSelectToInfoSetorEditors(),
                    );
                    // .then((value) => setState(() {}));
                  },
                )
              : Container(),
          !_public && widget.editorsMap != null && widget.editorsMap.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.editorsMap.length,
                    itemBuilder: (context, index) {
                      UserModel editorsList =
                          widget.editorsMap.entries.toList()[index].value;
                      return ListTile(
                        title: Text('${editorsList.name}'),
                        // trailing: IconButton(
                        //     icon: Icon(Icons.delete),
                        //     onPressed: () {
                        //       widget.onSetWorkerTheGroupSyncGroupAction(
                        //         clone,
                        //         false,
                        //       );
                        //       // setState(() {});
                        //     }),
                      );
                    },
                  ),
                )
              : Container(),
          ListTile(
            title: Text(
                'Há ${(widget.valueMap != null && widget.valueMap.isNotEmpty) ? widget.valueMap.length : null} informações.'),
            leading: Icon(Icons.search),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => InfoCodeSelectToInfoSetorValue(),
              );
              // .then((value) => setState(() {}));
            },
          ),
          widget.valueMap != null && widget.valueMap.isNotEmpty
              ? Container(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.valueMap.length,
                    itemBuilder: (context, index) {
                      ValueInfo valueInfo =
                          widget.valueMap.entries.toList()[index].value;
                      return ListTile(
                        title: Text(
                            '${valueInfo.infoCodeRef.code}-${valueInfo.infoCodeRef.name}'),
                        // trailing: IconButton(
                        //     icon: Icon(Icons.delete),
                        //     onPressed: () {
                        //       widget.onSetWorkerTheGroupSyncGroupAction(
                        //         clone,
                        //         false,
                        //       );
                        //       // setState(() {});
                        //     }),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
