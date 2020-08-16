import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:indis/models/info_category_model.dart';

class InfoCategoryTreeDS extends StatefulWidget {
  final Map<String, CategoryData> categoryDataMap;

  const InfoCategoryTreeDS({Key key, this.categoryDataMap}) : super(key: key);

  @override
  _InfoCategoryTreeDSState createState() => _InfoCategoryTreeDSState();
}

class _InfoCategoryTreeDSState extends State<InfoCategoryTreeDS> {
  final TreeController _controller = TreeController(allNodesExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Árvore de categorias ${widget.categoryDataMap?.length ?? null}'),
      ),
      body: SingleChildScrollView(child: buildTree()),
    );
  }

  List<TreeNode> recursiveNodes(
      List<TreeNode> _nodes, CategoryData categoryData) {
    print('recursiveNodes:>>>> ${categoryData.id}');
    CategoryData _categoryDataParent = widget.categoryDataMap.values.firstWhere(
        (element) => element.idParente == categoryData.id,
        orElse: () => null);
    if (_categoryDataParent != null) {
      print('!=null achei ${_categoryDataParent.id}');
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
      print('==null');
      List<TreeNode> _itensTree = [];
      categoryData.infoCodeRefMap.forEach((key, value) {
        _itensTree.add(TreeNode(content: Text(value.name)));
      });
      _nodes.add(
          TreeNode(content: Text(categoryData.name), children: _itensTree));
      return _nodes;
    }
  }

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

  Widget buildTree1() {
    return TreeView(
      treeController: _controller,
      nodes: [
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
                    TreeNode(
                      content: Text("node 21b"),
                      children: [
                        TreeNode(content: Text('b')),
                        TreeNode(
                          content: Text("node 21b"),
                          children: [
                            TreeNode(content: Text('b')),
                            TreeNode(
                              content: Text("node 21b"),
                              children: [
                                TreeNode(content: Text('b')),
                                TreeNode(
                                  content: Text("node 21b"),
                                  children: [
                                    TreeNode(content: Text('b')),
                                    TreeNode(
                                      content: Text("node 21b"),
                                      children: [
                                        TreeNode(content: Text('b')),
                                        TreeNode(
                                          content: Text("node 21b"),
                                          children: [
                                            TreeNode(content: Text('b'))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
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
}
