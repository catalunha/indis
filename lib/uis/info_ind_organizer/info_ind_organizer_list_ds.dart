import 'package:flutter/material.dart';
import 'package:indis/models/info_ind_organizer_model.dart';

class InfoIndOrganizerListDS extends StatelessWidget {
  final List<InfoIndOrganizerModel> infoIndOrganizerList;
  final Function(String) onEditInfoIndOrganizerCurrent;

  const InfoIndOrganizerListDS({
    Key key,
    this.infoIndOrganizerList,
    this.onEditInfoIndOrganizerCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${infoIndOrganizerList.length} organizadores'),
      ),
      body: ListView.builder(
        itemCount: infoIndOrganizerList.length,
        itemBuilder: (context, index) {
          final infoIndOrganizer = infoIndOrganizerList[index];
          return Card(
            child: ListTile(
              title: Text('${infoIndOrganizer.name}'),
              subtitle: Text('${infoIndOrganizer.name}\n$infoIndOrganizer'),
              onTap: () {
                onEditInfoIndOrganizerCurrent(infoIndOrganizer.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoIndOrganizerCurrent(null);
        },
      ),
    );
  }
}
