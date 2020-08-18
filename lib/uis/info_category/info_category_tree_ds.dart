import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:indis/conectors/info_code/info_code_select.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';

class InfoCategoryDataTreeDS extends StatefulWidget {
  final Map<String, CategoryData> categoryDataMap;
  final Function(String, bool) onEditInfoCategoryDataCurrent;
  final Function(String, bool) onSetInfoCategoryDataCurrent;
  final Function(InfoCodeModel)
      onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction;

  const InfoCategoryDataTreeDS({
    Key key,
    this.categoryDataMap,
    this.onEditInfoCategoryDataCurrent,
    this.onSetInfoCategoryDataCurrent,
    this.onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction,
  }) : super(key: key);

  @override
  _InfoCategoryDataTreeDSState createState() => _InfoCategoryDataTreeDSState();
}

class _InfoCategoryDataTreeDSState extends State<InfoCategoryDataTreeDS> {
  final TreeController _controller = TreeController(allNodesExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Árvore de categorias'),
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
          widget.onEditInfoCategoryDataCurrent(null, true);
        },
      ),
    );
  }

  Widget categoryDataContent(CategoryData categoryData) {
    return Row(
      children: [
        Text(categoryData.name),
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
            widget.onEditInfoCategoryDataCurrent(categoryData.id, false);
          },
        ),
        IconButton(
          tooltip: 'Acrescentar subcategoria',
          icon: Icon(
            Icons.add,
            size: 15,
          ),
          onPressed: () {
            widget.onEditInfoCategoryDataCurrent(categoryData.id, true);
          },
        ),
        IconButton(
          tooltip: 'Acrescentar informação',
          icon: Icon(
            Icons.add_comment,
            size: 15,
          ),
          onPressed: () {
            widget.onSetInfoCategoryDataCurrent(categoryData.id, false);
            showDialog(
              context: context,
              builder: (context) => InfoCodeSelect(),
            );
          },
        ),
      ],
    );
  }

  Widget infoCodeContent(
      InfoCodeModel infoCodeModel, CategoryData categoryData) {
    return Row(
      children: [
        Text(infoCodeModel.name),
        IconButton(
          tooltip: 'Editar informação',
          icon: Icon(
            Icons.assignment,
            size: 15,
          ),
          onPressed: () {},
        ),
        InkWell(
          child: Tooltip(
            message: 'Remover esta informação',
            child: Icon(
              Icons.delete,
              size: 15,
            ),
          ),
          onDoubleTap: () {
            widget.onSetInfoCategoryDataCurrent(categoryData.id, false);
            widget.onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction(
                infoCodeModel);
          },
        )
        // IconButton(
        //   tooltip: 'remover informação',
        //   icon: Icon(
        //     Icons.delete,
        //     size: 15,
        //   ),

        //   onPressed: () {
        //     widget.onSetInfoCategoryDataCurrent(categoryData.id, false);

        //     widget.onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction(
        //         infoCodeModel);
        //   },
        // ),
      ],
    );
  }

  TreeNode _treeNode(CategoryData categoryData) {
    Iterable<CategoryData> categoryDataParent = widget.categoryDataMap.values
        .where((element) => element.idParente == categoryData.id);
    if (categoryDataParent.isNotEmpty) {
      TreeNode treeNode =
          TreeNode(content: categoryDataContent(categoryData), children: []);
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: infoCodeContent(value, categoryData)));
      });
      for (var categoryDataParentItem in categoryDataParent) {
        treeNode.children.add(_treeNode(categoryDataParentItem));
      }
      treeNode.children.addAll(_itensTree);
      return treeNode;
    } else {
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: infoCodeContent(value, categoryData)));
      });
      return TreeNode(
          content: categoryDataContent(categoryData), children: _itensTree);
    }
  }

  Widget buildTree() {
    List<TreeNode> _nodes = [];
    Iterable<CategoryData> categoryDataidParentNull = widget
        .categoryDataMap.values
        .where((element) => element.idParente == null);
    for (var categoryDataKV in categoryDataidParentNull) {
      _nodes.add(_treeNode(categoryDataKV));
    }
    return TreeView(
      treeController: _controller,
      nodes: _nodes,
    );
  }

/*
codigo correto do treeView
 TreeNode _treeNode(CategoryData categoryData) {
    Iterable<CategoryData> categoryDataParent = widget.categoryDataMap.values
        .where((element) => element.idParente == categoryData.id);
    print('${categoryData.name} Parent:${categoryDataParent.length}');
    if (categoryDataParent.isNotEmpty) {
      TreeNode treeNode = TreeNode(
          key: ValueKey(categoryData.id),
          content: Text(categoryData.name),
          children: []);
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      for (var categoryDataParentItem in categoryDataParent) {
        treeNode.children.add(_treeNode(categoryDataParentItem));
      }
      treeNode.children.addAll(_itensTree);
      return treeNode;
    } else {
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      return TreeNode(
          key: ValueKey(categoryData.id),
          content: Text(categoryData.name),
          children: _itensTree);
    }
  }

  Widget buildTree() {
    List<TreeNode> _nodes = [];
    Iterable<CategoryData> categoryDataidParentNull = widget
        .categoryDataMap.values
        .where((element) => element.idParente == null);
    for (var categoryDataKV in categoryDataidParentNull) {
      _nodes.add(_treeNode(categoryDataKV));
    }
    return TreeView(
      treeController: _controller,
      nodes: _nodes,
    );
  }
*/

/*
  List<TreeNode> recursiveNodes(
      List<TreeNode> _nodes, CategoryData categoryData) {
    print('recursiveNodes:');
    print('_nodes:>>>> ${_nodes.length}');
    print('categoryData:>>>> ${categoryData.name}');

    Iterable<CategoryData> _categoryDataParent;
    if (categoryData != null) {
      _categoryDataParent = widget.categoryDataMap.values
          .where((element) => element.idParente == categoryData.id);
    }
    print('_categoryDataParent:>>>> ${_categoryDataParent.length}');
    if (_categoryDataParent != null && _categoryDataParent.length > 0) {
      for (var element in _categoryDataParent) {
        print('!=null ${element.name}');
        List<TreeNode> _itensTree = [];
        categoryData.infoCodeRefMap.forEach((key, value) {
          _itensTree.add(TreeNode(content: Text(value.name)));
        });
        _nodes.add(TreeNode(content: Text(categoryData.name), children: [
          ...recursiveNodes(_nodes, element),
          ..._itensTree,
        ]));
        return _nodes;
      }
    } else {
      print('==null ${categoryData.name}');
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      _nodes.add(
          TreeNode(content: Text(categoryData.name), children: _itensTree));
      return _nodes;
    }
*/
  //+++ metodo 1
/*
    CategoryData _categoryDataParent = widget.categoryDataMap.values.firstWhere(
        (element) => element.idParente == categoryData.id,
        orElse: () => null);
    if (_categoryDataParent != null) {
      print('!=null ${_categoryDataParent.name}');
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      return [
        TreeNode(content: Text(categoryData.name), children: [
          ...recursiveNodes(
              _nodes, widget.categoryDataMap[_categoryDataParent.id]),
          ..._itensTree,
        ])
      ];
    } else {
      print('==null ${categoryData.name}');
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      _nodes.add(
          TreeNode(content: Text(categoryData.name), children: _itensTree));
      return _nodes;
    }
*/
  //--- metodo 1
  //}

/*
  Widget buildTree() {
    List<TreeNode> _nodes = [];
    List<String> keysMap = widget.categoryDataMap.keys.toList();

    _nodes = recursiveNodes(_nodes, widget.categoryDataMap[keysMap.first]);
    // }
    // widget.categoryDataMap.forEach((key, value) {
    //   List<TreeNode> _itensTree = [];
    //   CategoryData categoryData = widget.categoryDataMap.values
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
