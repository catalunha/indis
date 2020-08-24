import 'package:flutter/material.dart';
import 'package:indis/conectors/info_category/info_category_select_to_copyitemmap.dart';
import 'package:indis/conectors/info_setor/info_setor_select_to_infocategorysetor%20.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoCategoryEditDS extends StatefulWidget {
  final String name;
  final String description;
  final bool public;
  final InfoSetorModel setorRef;
  final bool containItemMap;
  final bool isCreateOrUpdate;
  final Function(String, String, bool) onCreate;
  final Function(String, String, bool) onUpdate;
  // final Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;
  // final Map<String, InfoCodeModel> infoCodeRefMap;

  const InfoCategoryEditDS({
    Key key,
    this.name,
    this.description,
    this.public,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.containItemMap,
    this.setorRef,
    // this.onSetInfoCodeInInfoCategory,
    // this.infoCodeRefMap,
  }) : super(key: key);
  @override
  _InfoCategoryEditDSState createState() => _InfoCategoryEditDSState();
}

class _InfoCategoryEditDSState extends State<InfoCategoryEditDS> {
  final formKey = GlobalKey<FormState>();
  String _description;
  String _name;
  bool _public;
  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_name, _description, _public)
          : widget.onUpdate(_name, _description, _public);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _public = widget.public ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isCreateOrUpdate ? 'Criar categoria' : 'Editar categoria'),
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
          SwitchListTile(
            value: _public,
            title: Text('Deixar pública minha árvore de categorias ?'),
            onChanged: (value) {
              setState(() {
                _public = value;
              });
            },
          ),
          ListTile(
            title: Text('Qual a área associada a estas categorias ?'),
            subtitle: Text(
                '${widget.setorRef?.code}-${widget.setorRef?.uf}-${widget.setorRef?.city}'),
            leading: Icon(Icons.search),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => InfoSetorSelectToInfoCategorySetor(),
              );
            },
          ),
          widget.isCreateOrUpdate
              ? ListTile(
                  title: Text(
                      'Deseja copiar a árvore de categorias de um autor ?'),
                  subtitle: widget.containItemMap
                      ? Text('Cópia realizada com sucesso')
                      : Text('Arvore atual sem itens.'),
                  leading: Icon(Icons.search),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => InfoCategorySelectToCopyItemMap(),
                    );
                  },
                )
              : Container(),
          // ListTile(
          //   title: Text(
          //       'Há ${widget.infoCodeRefMap != null && widget.infoCodeRefMap.isNotEmpty ? widget.infoCodeRefMap.length : null} informações nesta categoria'),
          //   trailing: Icon(Icons.search),
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) => InfoCodeSelect(),
          //     );
          //     // .then((value) => setState(() {}));
          //   },
          // ),
          // widget.infoCodeRefMap != null && widget.infoCodeRefMap.isNotEmpty
          //     ? Container(
          //         width: double.infinity,
          //         height: 100,
          //         child: ListView.builder(
          //           itemCount: widget.infoCodeRefMap.length,
          //           itemBuilder: (context, index) {
          //             InfoCodeModel infoCodeRef =
          //                 widget.infoCodeRefMap.entries.toList()[index].value;
          //             return ListTile(
          //               title: Text('$infoCodeRef'),
          //               trailing: IconButton(
          //                   icon: Icon(Icons.delete),
          //                   onPressed: () {
          //                     widget.onSetInfoCodeInInfoCategory(
          //                       infoCodeRef,
          //                       false,
          //                     );
          //                     // setState(() {});
          //                   }),
          //             );
          //           },
          //         ),
          //       )
          //     : Container(),
        ],
      ),
    );
  }
}
