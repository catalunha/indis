import 'package:flutter/material.dart';
import 'package:indis/models/information_owner_model.dart';

class InformationOwnerListDS extends StatelessWidget {
  final List<InformationOwnerModel> informationOwnerList;
  final Function(String) onEditInformationOwnerCurrent;

  const InformationOwnerListDS({
    Key key,
    this.informationOwnerList,
    this.onEditInformationOwnerCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${informationOwnerList.length} proprietários'),
      ),
      body: ListView.builder(
        itemCount: informationOwnerList.length,
        itemBuilder: (context, index) {
          final module = informationOwnerList[index];
          return Card(
            child: ListTile(
              selected: module.arquived ?? false,
              title: Text('${module.code}'),
              subtitle: Text('${module.name}\n${module.description}'),
              onTap: () {
                onEditInformationOwnerCurrent(module.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInformationOwnerCurrent(null);
        },
      ),
    );
  }
}
