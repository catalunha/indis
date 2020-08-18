import 'package:flutter/material.dart';
import 'package:indis/models/info_code_model.dart';

class InfoCodeSelectToInfoCodeCloneDS extends StatefulWidget {
  final List<InfoCodeModel> infoCodeList;
  final List<String> infoCodeCurrentCloneMapKeys;
  final Function(InfoCodeModel, bool)
      onSetInfoCodeInInfoCodeCloneMapSyncGroupAction;

  const InfoCodeSelectToInfoCodeCloneDS({
    Key key,
    this.onSetInfoCodeInInfoCodeCloneMapSyncGroupAction,
    this.infoCodeList,
    this.infoCodeCurrentCloneMapKeys,
  }) : super(key: key);
  @override
  _InfoCodeSelectToInfoCodeCloneDSState createState() =>
      _InfoCodeSelectToInfoCodeCloneDSState();
}

class _InfoCodeSelectToInfoCodeCloneDSState
    extends State<InfoCodeSelectToInfoCodeCloneDS> {
  @override
  Widget build(BuildContext context) {
    print(widget.infoCodeList);
    print(widget.infoCodeCurrentCloneMapKeys);
    return Dialog(
      child: Container(
        height: 700.0,
        width: 800.0,
        child: ListView.builder(
          itemCount: widget.infoCodeList.length,
          itemBuilder: (context, index) {
            final infoCode = widget.infoCodeList[index];

            return ListTile(
              selected: widget.infoCodeCurrentCloneMapKeys != null
                  ? widget.infoCodeCurrentCloneMapKeys.contains(infoCode.id)
                  : false,
              title: Text('${infoCode.code}'),
              subtitle: Text('${infoCode.name}\nworkerModel: $infoCode'),
              onTap: () {
                widget.onSetInfoCodeInInfoCodeCloneMapSyncGroupAction(
                    infoCode,
                    !(widget.infoCodeCurrentCloneMapKeys != null
                        ? widget.infoCodeCurrentCloneMapKeys
                            .contains(infoCode.id)
                        : false));
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
