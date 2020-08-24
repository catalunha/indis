import 'package:flutter/material.dart';
import 'package:indis/models/info_code_model.dart';

class InfoCodeSelectToInfoSetorValueDS extends StatefulWidget {
  final List<InfoCodeModel> infoCodeList;
  final List<String> infoSetorCurrentValueMapKeys;
  final Function(InfoCodeModel, bool)
      onSetInfoCodeInInfoSetorValueMapSyncGroupAction;

  const InfoCodeSelectToInfoSetorValueDS({
    Key key,
    this.onSetInfoCodeInInfoSetorValueMapSyncGroupAction,
    this.infoCodeList,
    this.infoSetorCurrentValueMapKeys,
  }) : super(key: key);
  @override
  _InfoCodeSelectToInfoSetorValueDSState createState() =>
      _InfoCodeSelectToInfoSetorValueDSState();
}

class _InfoCodeSelectToInfoSetorValueDSState
    extends State<InfoCodeSelectToInfoSetorValueDS> {
  @override
  Widget build(BuildContext context) {
    print(widget.infoCodeList);
    print(widget.infoSetorCurrentValueMapKeys);
    return Dialog(
      child: Container(
        height: 700.0,
        width: 800.0,
        child: ListView.builder(
          itemCount: widget.infoCodeList.length,
          itemBuilder: (context, index) {
            final infoCode = widget.infoCodeList[index];

            return ListTile(
              selected: widget.infoSetorCurrentValueMapKeys != null
                  ? widget.infoSetorCurrentValueMapKeys.contains(infoCode.id)
                  : false,
              title: Text('${infoCode.code}'),
              subtitle: Text('${infoCode.name}\nworkerModel: $infoCode'),
              onTap: () {
                widget.onSetInfoCodeInInfoSetorValueMapSyncGroupAction(
                    infoCode,
                    !(widget.infoSetorCurrentValueMapKeys != null
                        ? widget.infoSetorCurrentValueMapKeys
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
