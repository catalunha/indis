import 'package:flutter/material.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoSetorListDS extends StatelessWidget {
  final List<InfoSetorModel> infoSetorList;
  final Function(String) onEditInfoSetorCurrent;

  const InfoSetorListDS({
    Key key,
    this.infoSetorList,
    this.onEditInfoSetorCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${infoSetorList.length} município/setor'),
      ),
      body: ListView.builder(
        itemCount: infoSetorList.length,
        itemBuilder: (context, index) {
          final infoSetor = infoSetorList[index];
          return Card(
            child: ListTile(
              title: Text('${infoSetor.code}'),
              subtitle: Text('${infoSetor.toString()}'),
              onTap: () {
                onEditInfoSetorCurrent(infoSetor.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoSetorCurrent(null);
        },
      ),
    );
  }
}
