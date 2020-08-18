import 'package:flutter/material.dart';
import 'package:indis/models/info_code_model.dart';

class InfoCodeListDS extends StatelessWidget {
  final List<InfoCodeModel> infoCodeList;
  final Function(String) onEditInfoCodeCurrent;

  const InfoCodeListDS({
    Key key,
    this.infoCodeList,
    this.onEditInfoCodeCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Lista de informações cadastradas (${infoCodeList.length})'),
      ),
      body: ListView.builder(
        itemCount: infoCodeList.length,
        itemBuilder: (context, index) {
          final infoCode = infoCodeList[index];
          return Card(
            child: ListTile(
              selected: infoCode.arquived ?? false,
              title: Text('${infoCode.code}'),
              subtitle: Text(
                  '${infoCode.name}\n${infoCode.description}\n${infoCode.unit}\n${infoCode.infoIndOwnerRef.name}\nClones:${infoCode.toStringInfoCodeCloneMap()}\n\n$infoCode'),
              onTap: () {
                onEditInfoCodeCurrent(infoCode.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoCodeCurrent(null);
        },
      ),
    );
  }
}
