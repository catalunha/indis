import 'package:flutter/material.dart';

class UserLoggedEditDS extends StatefulWidget {
  final String email;
  final String name;

  final Function() onUpdate;

  const UserLoggedEditDS({
    this.email,
    Key key,
    this.name,
    this.onUpdate,
  }) : super(key: key);
  @override
  _UserLoggedEditDSState createState() => _UserLoggedEditDSState();
}

class _UserLoggedEditDSState extends State<UserLoggedEditDS> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onUpdate();
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar dados do usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.0),
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
        children: <Widget>[
          ListTile(
            title: Text('${widget.name}'),
            subtitle: Text('Nome completo'),
          ),
          ListTile(
            title: Text('${widget.email}'),
            subtitle: Text('Email'),
          ),
        ],
      ),
    );
  }
}
