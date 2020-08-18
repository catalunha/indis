import 'package:flutter/material.dart';
import 'package:indis/models/info_code_model.dart';

class InfoCodeSelectToInfoCodeLinkDS extends StatefulWidget {
  final List<InfoCodeModel> infoCodeList;
  final List<String> infoCodeCurrentLinkMapKeys;
  final Function(InfoCodeModel, bool)
      onSetInfoCodeInInfoCodeLinkMapSyncGroupAction;

  const InfoCodeSelectToInfoCodeLinkDS({
    Key key,
    this.onSetInfoCodeInInfoCodeLinkMapSyncGroupAction,
    this.infoCodeList,
    this.infoCodeCurrentLinkMapKeys,
  }) : super(key: key);
  @override
  _InfoCodeSelectToInfoCodeLinkDSState createState() =>
      _InfoCodeSelectToInfoCodeLinkDSState();
}

class _InfoCodeSelectToInfoCodeLinkDSState
    extends State<InfoCodeSelectToInfoCodeLinkDS> {
  @override
  Widget build(BuildContext context) {
    print(widget.infoCodeList);
    print(widget.infoCodeCurrentLinkMapKeys);
    return Dialog(
      child: Container(
        height: 700.0,
        width: 800.0,
        child: ListView.builder(
          itemCount: widget.infoCodeList.length,
          itemBuilder: (context, index) {
            final infoCode = widget.infoCodeList[index];

            return ListTile(
              selected: widget.infoCodeCurrentLinkMapKeys != null
                  ? widget.infoCodeCurrentLinkMapKeys.contains(infoCode.id)
                  : false,
              title: Text('${infoCode.code}'),
              subtitle: Text('${infoCode.name}\nworkerModel: $infoCode'),
              onTap: () {
                widget.onSetInfoCodeInInfoCodeLinkMapSyncGroupAction(
                    infoCode,
                    !(widget.infoCodeCurrentLinkMapKeys != null
                        ? widget.infoCodeCurrentLinkMapKeys
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
