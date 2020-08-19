import 'package:flutter/material.dart';
import 'package:indis/models/info_ind_owner_model.dart';

class InfoindOwnerSelectToInfoCodeDS extends StatelessWidget {
  final List<InfoIndOwnerModel> infoIndOwnerList;
  final Function(InfoIndOwnerModel) onSetInfoIndOwnerInInfoCode;

  const InfoindOwnerSelectToInfoCodeDS({
    Key key,
    this.infoIndOwnerList,
    this.onSetInfoIndOwnerInInfoCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: infoIndOwnerList.length,
          itemBuilder: (context, index) {
            final infoIndOwner = infoIndOwnerList[index];
            return ListTile(
              title: Text('${infoIndOwner.code}'),
              subtitle: Text('${infoIndOwner.name}'),
              onTap: () {
                onSetInfoIndOwnerInInfoCode(infoIndOwner);
              },
            );
          },
        ),
      ),
    );
  }
}
