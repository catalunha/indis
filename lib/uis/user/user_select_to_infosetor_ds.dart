import 'package:flutter/material.dart';
import 'package:indis/models/user_model.dart';

class UserSelectToInfoSetorEditorsDS extends StatefulWidget {
  final List<UserModel> userModelList;
  final List<String> infoSetorCurrentEditorsMapKeys;
  final Function(UserModel, bool) onSetUserInInfoSetorEditorsMap;

  const UserSelectToInfoSetorEditorsDS({
    Key key,
    this.onSetUserInInfoSetorEditorsMap,
    this.userModelList,
    this.infoSetorCurrentEditorsMapKeys,
  }) : super(key: key);
  @override
  _UserSelectToInfoSetorEditorsDSState createState() =>
      _UserSelectToInfoSetorEditorsDSState();
}

class _UserSelectToInfoSetorEditorsDSState
    extends State<UserSelectToInfoSetorEditorsDS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 700.0,
        width: 800.0,
        child: ListView.builder(
          itemCount: widget.userModelList.length,
          itemBuilder: (context, index) {
            final userModel = widget.userModelList[index];

            return ListTile(
              selected: widget.infoSetorCurrentEditorsMapKeys != null
                  ? widget.infoSetorCurrentEditorsMapKeys.contains(userModel.id)
                  : false,
              title: Text('${userModel.name}'),
              subtitle: Text('${userModel.email}'),
              onTap: () {
                widget.onSetUserInInfoSetorEditorsMap(
                    userModel,
                    !(widget.infoSetorCurrentEditorsMapKeys != null
                        ? widget.infoSetorCurrentEditorsMapKeys
                            .contains(userModel.id)
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
