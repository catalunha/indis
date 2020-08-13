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
        title: Text('Lista com ${infoIndOwnerList.length} proprietários'),
      ),
      body: ListView.builder(
        itemCount: infoIndOwnerList.length,
        itemBuilder: (context, index) {
          final module = infoIndOwnerList[index];
          return Card(
            child: ListTile(
              selected: module.arquived ?? false,
              title: Text('${module.code}'),
              subtitle: Text('${module.name}\n${module.description}'),
              onTap: () {
                onEditInfoIndOwnerCurrent(module.id);
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
