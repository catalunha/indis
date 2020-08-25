import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:indis/conectors/info_code/info_code_select_to_infocategoryitem.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoCategoryItemTreeDS extends StatefulWidget {
  final Map<String, InfoCategoryItem> itemMap;
  final InfoSetorModel infoSetorModel;
  final InfoCategoryModel infoCategoryModel;
  final Function(String, bool) onEditInfoCategoryItemCurrent;
  final Function(String, bool) onSetInfoCategoryItemCurrent;
  final Function(InfoCodeModel)
      onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction;

  const InfoCategoryItemTreeDS({
    Key key,
    this.itemMap,
    this.onEditInfoCategoryItemCurrent,
    this.onSetInfoCategoryItemCurrent,
    this.onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction,
    this.infoSetorModel,
    this.infoCategoryModel,
  }) : super(key: key);

  @override
  _InfoCategoryItemTreeDSState createState() => _InfoCategoryItemTreeDSState();
}

class _InfoCategoryItemTreeDSState extends State<InfoCategoryItemTreeDS> {
  final TreeController _controller = TreeController(allNodesExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Árvore de categorias das informações (${widget.itemMap?.length})'),
        actions: [
          widget.infoCategoryModel.setorRef != null
              ? IconButton(
                  icon: Icon(Icons.book),
                  onPressed: () {},
                )
              : Container()
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: buildTree(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Acrescentar categoria',
        onPressed: () {
          widget.onEditInfoCategoryItemCurrent(null, true);
        },
      ),
    );
  }

  Widget categoryItemContent(InfoCategoryItem categoryItem) {
    return Row(
      children: [
        Text('${categoryItem.name}'),
        SizedBox(
          height: 5,
        ),
        IconButton(
          tooltip: 'Editar esta categoria',
          icon: Icon(
            Icons.edit,
            size: 15,
          ),
          onPressed: () {
            widget.onEditInfoCategoryItemCurrent(categoryItem.id, false);
          },
        ),
        IconButton(
          tooltip: 'Acrescentar subcategoria',
          icon: Icon(
            Icons.add,
            size: 15,
          ),
          onPressed: () {
            widget.onEditInfoCategoryItemCurrent(categoryItem.id, true);
          },
        ),
        IconButton(
          tooltip: 'Acrescentar informação',
          icon: Icon(
            Icons.add_comment,
            size: 15,
          ),
          onPressed: () {
            widget.onSetInfoCategoryItemCurrent(categoryItem.id, false);
            showDialog(
              context: context,
              builder: (context) => InfoCodeSelectToInfoCategoryItem(),
            );
          },
        ),
      ],
    );
  }

  Widget infoCodeContent(
      InfoCodeModel infoCodeModel, InfoCategoryItem categoryItem) {
    bool containInfoCode = false;
    if (widget.infoCategoryModel.setorRef != null) {
      containInfoCode =
          widget.infoSetorModel.valueMap.containsKey(infoCodeModel.id);
    }
    return Row(
      children: [
        InkWell(
          child: Tooltip(
            message: 'Remover esta informação',
            child: Icon(
              Icons.delete,
              size: 15,
            ),
          ),
          onDoubleTap: () {
            widget.onSetInfoCategoryItemCurrent(categoryItem.id, false);
            widget.onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction(
                infoCodeModel);
          },
        ),
        Text('${infoCodeModel.code}-${infoCodeModel.name}'),
        containInfoCode
            ? IconButton(
                tooltip: 'Editar informação',
                icon: Icon(
                  Icons.assignment,
                  size: 15,
                ),
                onPressed: () {},
              )
            : Container(),

        // IconButton(
        //   tooltip: 'remover informação',
        //   icon: Icon(
        //     Icons.delete,
        //     size: 15,
        //   ),

        //   onPressed: () {
        //     widget.onSetInfoCategoryItemCurrent(categoryItem.id, false);

        //     widget.onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction(
        //         infoCodeModel);
        //   },
        // ),
      ],
    );
  }

  TreeNode _treeNode(InfoCategoryItem categoryItem) {
    Iterable<InfoCategoryItem> categoryItemParent = widget.itemMap.values
        .where((element) => element.idParente == categoryItem.id);
    if (categoryItemParent.isNotEmpty) {
      TreeNode treeNode =
          TreeNode(content: categoryItemContent(categoryItem), children: []);
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: infoCodeContent(value, categoryItem)));
      });
      for (var categoryItemParentItem in categoryItemParent) {
        treeNode.children.add(_treeNode(categoryItemParentItem));
      }
      treeNode.children.addAll(_itensTree);
      return treeNode;
    } else {
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: infoCodeContent(value, categoryItem)));
      });
      return TreeNode(
          content: categoryItemContent(categoryItem), children: _itensTree);
    }
  }

  Widget buildTree() {
    List<TreeNode> _nodes = [];
    Iterable<InfoCategoryItem> categoryItemidParentNull =
        widget.itemMap.values.where((element) => element.idParente == null);
    for (var categoryItemKV in categoryItemidParentNull) {
      _nodes.add(_treeNode(categoryItemKV));
    }
    return TreeView(
      treeController: _controller,
      nodes: _nodes,
    );
  }

/*
codigo correto do treeView
 TreeNode _treeNode(CategoryData categoryItem) {
    Iterable<CategoryData> categoryItemParent = widget.itemMap.values
        .where((element) => element.idParente == categoryItem.id);
    print('${categoryItem.name} Parent:${categoryItemParent.length}');
    if (categoryItemParent.isNotEmpty) {
      TreeNode treeNode = TreeNode(
          key: ValueKey(categoryItem.id),
          content: Text(categoryItem.name),
          children: []);
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      for (var categoryItemParentItem in categoryItemParent) {
        treeNode.children.add(_treeNode(categoryItemParentItem));
      }
      treeNode.children.addAll(_itensTree);
      return treeNode;
    } else {
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      return TreeNode(
          key: ValueKey(categoryItem.id),
          content: Text(categoryItem.name),
          children: _itensTree);
    }
  }

  Widget buildTree() {
    List<TreeNode> _nodes = [];
    Iterable<CategoryData> categoryItemidParentNull = widget
        .itemMap.values
        .where((element) => element.idParente == null);
    for (var categoryItemKV in categoryItemidParentNull) {
      _nodes.add(_treeNode(categoryItemKV));
    }
    return TreeView(
      treeController: _controller,
      nodes: _nodes,
    );
  }
*/

/*
  List<TreeNode> recursiveNodes(
      List<TreeNode> _nodes, CategoryData categoryItem) {
    print('recursiveNodes:');
    print('_nodes:>>>> ${_nodes.length}');
    print('categoryItem:>>>> ${categoryItem.name}');

    Iterable<CategoryData> _categoryItemParent;
    if (categoryItem != null) {
      _categoryItemParent = widget.itemMap.values
          .where((element) => element.idParente == categoryItem.id);
    }
    print('_categoryItemParent:>>>> ${_categoryItemParent.length}');
    if (_categoryItemParent != null && _categoryItemParent.length > 0) {
      for (var element in _categoryItemParent) {
        print('!=null ${element.name}');
        List<TreeNode> _itensTree = [];
        categoryItem.infoCodeRefMap.forEach((key, value) {
          _itensTree.add(TreeNode(content: Text(value.name)));
        });
        _nodes.add(TreeNode(content: Text(categoryItem.name), children: [
          ...recursiveNodes(_nodes, element),
          ..._itensTree,
        ]));
        return _nodes;
      }
    } else {
      print('==null ${categoryItem.name}');
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      _nodes.add(
          TreeNode(content: Text(categoryItem.name), children: _itensTree));
      return _nodes;
    }
*/
  //+++ metodo 1
/*
    CategoryData _categoryItemParent = widget.itemMap.values.firstWhere(
        (element) => element.idParente == categoryItem.id,
        orElse: () => null);
    if (_categoryItemParent != null) {
      print('!=null ${_categoryItemParent.name}');
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      return [
        TreeNode(content: Text(categoryItem.name), children: [
          ...recursiveNodes(
              _nodes, widget.itemMap[_categoryItemParent.id]),
          ..._itensTree,
        ])
      ];
    } else {
      print('==null ${categoryItem.name}');
      List<TreeNode> _itensTree = [];
      categoryItem.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      _nodes.add(
          TreeNode(content: Text(categoryItem.name), children: _itensTree));
      return _nodes;
    }
*/
  //--- metodo 1
  //}

/*
  Widget buildTree() {
    List<TreeNode> _nodes = [];
    List<String> keysMap = widget.itemMap.keys.toList();

    _nodes = recursiveNodes(_nodes, widget.itemMap[keysMap.first]);
    // }
    // widget.itemMap.forEach((key, value) {
    //   List<TreeNode> _itensTree = [];
    //   CategoryData categoryItem = widget.itemMap.values
    //       .firstWhere((element) => element.idParente == key);
    //   //   value.infoCodeRefMap.forEach((key, value) {
    //   //     _itensTree.add(TreeNode(content: Text(value.name)));
    //   //   });

    //   _nodes.add(TreeNode(content: Text(value.name), children: _itensTree));
    // });

    return TreeView(
      treeController: _controller,
      nodes: _nodes,
    );
  }
*/
/*
  Widget buildTree1() {
    List<TreeNode> treenode = [];
    treenode
        .add(TreeNode(key: ValueKey('a'), content: Text("a"), children: []));
    print('${treenode.length}');
    for (var item in treenode) {
      if (item.key == ValueKey('a')) {
        item.children.add(
            TreeNode(key: ValueKey('b'), content: Text("b"), children: []));
      }
    }
    // print('${treenode.}');

    for (var item in treenode) {
      if (item.key == ValueKey('b')) {
        item.children.add(TreeNode(
          key: ValueKey('c'),
          content: Text("c"),
        ));
      }
    }
    print('${treenode.length}');

    return TreeView(
      treeController: _controller,
      nodes: [
        ...treenode,
        TreeNode(
          content: Text("node 1"),
        ),
        TreeNode(content: Text("node 21")),
        TreeNode(
          content: Icon(Icons.audiotrack),
          children: [
            TreeNode(
              content: Text("node 21b"),
              children: [
                TreeNode(content: Text('b')),
                TreeNode(
                  content: Text("node 21b"),
                  children: [
                    TreeNode(content: Text('b')),
                    // TreeNode(
                    //   content: Text("node 21b"),
                    //   children: [
                    //     TreeNode(content: Text('b')),
                    //     TreeNode(
                    //       content: Text("node 21b"),
                    //       children: [
                    //         TreeNode(content: Text('b')),
                    //         TreeNode(
                    //           content: Text("node 21b"),
                    //           children: [
                    //             TreeNode(content: Text('b')),
                    //             TreeNode(
                    //               content: Text("node 21b"),
                    //               children: [
                    //                 TreeNode(content: Text('b')),
                    //                 TreeNode(
                    //                   content: Text("node 21b"),
                    //                   children: [
                    //                     TreeNode(content: Text('b')),
                    //                     TreeNode(
                    //                       content: Text("node 21b"),
                    //                       children: [
                    //                         TreeNode(content: Text('b'))
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
            TreeNode(
              content: Text("node 22"),
              children: [
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
              ],
            ),
            TreeNode(
                content: Container(
              child: IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {},
              ),
              color: Colors.blue,
            )),
            TreeNode(content: Text("node 21")),
            TreeNode(content: Text("node 21")),
            TreeNode(
              content: Text("node 22a"),
              children: [
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
                TreeNode(
                  content: Icon(Icons.sentiment_very_satisfied),
                ),
              ],
            ),
            TreeNode(content: Text("node 21")),
            TreeNode(content: Text("node 21")),
            TreeNode(content: Text("node 21")),
            TreeNode(
              content: Text("node 23"),
            ),
          ],
        ),
      ],
    );
  }
  */
}
