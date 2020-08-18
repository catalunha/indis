import 'package:flutter/material.dart';
import 'package:indis/models/info_ind_owner_model.dart';

class InfoIndOwnerListDS extends StatelessWidget {
  final List<InfoIndOwnerModel> infoIndOwnerList;
  final Function(String) onEditInfoIndOwnerCurrent;

  const InfoIndOwnerListDS({
    Key key,
    this.infoIndOwnerList,
    this.onEditInfoIndOwnerCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Lista de proprietários de informações e indicadores (${infoIndOwnerList.length})'),
      ),
      body: ListView.builder(
        itemCount: infoIndOwnerList.length,
        itemBuilder: (context, index) {
          final infoIndOwner = infoIndOwnerList[index];
          return Card(
            child: ListTile(
              selected: infoIndOwner.arquived ?? false,
              title: Text('${infoIndOwner.code}'),
              subtitle:
                  Text('${infoIndOwner.name}\n${infoIndOwner.description}'),
              onTap: () {
                onEditInfoIndOwnerCurrent(infoIndOwner.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoIndOwnerCurrent(null);
        },
      ),
    );
  }
}
