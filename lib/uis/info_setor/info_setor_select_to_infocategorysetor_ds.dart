import 'package:flutter/material.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoSetorSelectToInfoCategorySetorDS extends StatefulWidget {
  final List<InfoSetorModel> infoSetorList;
  final String infoCategoryCurrentSetorRefId;
  final Function(InfoSetorModel, bool)
      onSetInfoSetorInInfoCategorySetorSyncGroupAction;

  const InfoSetorSelectToInfoCategorySetorDS({
    Key key,
    this.onSetInfoSetorInInfoCategorySetorSyncGroupAction,
    this.infoSetorList,
    this.infoCategoryCurrentSetorRefId,
  }) : super(key: key);
  @override
  _InfoSetorSelectToInfoCategorySetorDSState createState() =>
      _InfoSetorSelectToInfoCategorySetorDSState();
}

class _InfoSetorSelectToInfoCategorySetorDSState
    extends State<InfoSetorSelectToInfoCategorySetorDS> {
  @override
  Widget build(BuildContext context) {
    print(widget.infoSetorList);
    print(widget.infoCategoryCurrentSetorRefId);
    return Dialog(
      child: Container(
        height: 700.0,
        width: 800.0,
        child: ListView.builder(
          itemCount: widget.infoSetorList.length,
          itemBuilder: (context, index) {
            final infoSetor = widget.infoSetorList[index];

            return ListTile(
              selected: widget.infoCategoryCurrentSetorRefId == infoSetor.id,
              title: Text('${infoSetor.code}'),
              subtitle: Text('${infoSetor.uf}${infoSetor.city}'),
              onTap: () {
                widget.onSetInfoSetorInInfoCategorySetorSyncGroupAction(
                    infoSetor,
                    !(widget.infoCategoryCurrentSetorRefId == infoSetor.id));
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
