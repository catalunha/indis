import 'package:flutter/material.dart';

class InfoCategoryEditDS extends StatefulWidget {
  final String name;
  final String description;
  final bool isCreateOrUpdate;
  final Function(String, String) onCreate;
  final Function(String, String) onUpdate;
  // final Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;
  // final Map<String, InfoCodeModel> infoCodeRefMap;

  const InfoCategoryEditDS({
    Key key,
    this.description,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.name,
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
