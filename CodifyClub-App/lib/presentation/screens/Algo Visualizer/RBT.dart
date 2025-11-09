import 'dart:math';

import 'package:flutter/material.dart';

class RedBlackTreeVisualizer extends StatefulWidget {
  @override
  _RedBlackTreeVisualizerState createState() => _RedBlackTreeVisualizerState();
}

class _RedBlackTreeVisualizerState extends State<RedBlackTreeVisualizer> {
  final RedBlackTree _tree = RedBlackTree();
  final TextEditingController _controller = TextEditingController();

  void _insertNode() {
    if (_controller.text.isNotEmpty) {
      int value = int.parse(_controller.text);
      _tree.insert(value);
      setState(() {}); // Rebuild the UI after insertion
      _controller.clear(); // Clear the input
    }
  }

  void _deleteNode() {
    if (_controller.text.isNotEmpty) {
      int value = int.parse(_controller.text);
      _tree.delete(value);
      setState(() {}); // Rebuild the UI after deletion
      _controller.clear(); // Clear the input
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Red-Black Tree Visualizer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Enter Node Value'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: _insertNode,
                  child: Text('Insert'),
                ),
                ElevatedButton(
                  onPressed: _deleteNode,
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomPaint(
              painter: TreePainter(_tree.root),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class TreePainter extends CustomPainter {
  final Node? root;

  TreePainter(this.root);

  @override
  void paint(Canvas canvas, Size size) {
    if (root != null) {
      _drawNode(canvas, root!, Offset(size.width / 2, 50), size.width / 4);
    }
  }

  void _drawNode(Canvas canvas, Node node, Offset position, double xOffset) {
    Paint paint = Paint()
      ..color = (node.color == NodeColor.red) ? Colors.red : Colors.black;

    // Draw the node as a circle
    canvas.drawCircle(position, 20, paint);

    // Draw the node value centered inside the circle
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.data.toString(),
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Center the text inside the circle
    textPainter.paint(canvas, position - Offset(textPainter.width / 2, textPainter.height / 2));

    // Draw left and right children recursively
    if (node.left != null) {
      Offset leftChildPosition = Offset(position.dx - xOffset, position.dy + 80);
      _drawLine(canvas, position, leftChildPosition);
      _drawNode(canvas, node.left!, leftChildPosition, xOffset / 2);
    }

    if (node.right != null) {
      Offset rightChildPosition = Offset(position.dx + xOffset, position.dy + 80);
      _drawLine(canvas, position, rightChildPosition);
      _drawNode(canvas, node.right!, rightChildPosition, xOffset / 2);
    }
  }

  void _drawLine(Canvas canvas, Offset start, Offset end) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Calculate the direction to offset the start point so it's outside the circle
    double dx = end.dx - start.dx;
    double dy = end.dy - start.dy;
    double distance = sqrt(dx * dx + dy * dy);
    double offsetX = 20 * dx / distance; // Adjust the offset based on the radius
    double offsetY = 20 * dy / distance; // Adjust the offset based on the radius

    Offset startOffset = Offset(start.dx + offsetX, start.dy + offsetY);
    canvas.drawLine(startOffset, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

enum NodeColor { red, black }

class Node {
  int data;
  NodeColor color;
  Node? left;
  Node? right;
  Node? parent;

  Node(this.data, {this.color = NodeColor.red, this.left, this.right, this.parent});
}

class RedBlackTree {
  Node? root;

  // Insert a new node into the Red-Black Tree
  void insert(int data) {
    Node newNode = Node(data);
    if (root == null) {
      root = newNode;
      root!.color = NodeColor.black;
    } else {
      root = _insert(root!, newNode);
      _fixInsertion(newNode);
    }
  }

  // Insert helper method
  Node _insert(Node root, Node node) {
    if (node.data < root.data) {
      if (root.left == null) {
        root.left = node;
        node.parent = root;
      } else {
        _insert(root.left!, node);
      }
    } else {
      if (root.right == null) {
        root.right = node;
        node.parent = root;
      } else {
        _insert(root.right!, node);
      }
    }
    return root;
  }

  // Fix the Red-Black Tree after insertion
  void _fixInsertion(Node node) {
    while (node != root && node.parent!.color == NodeColor.red) {
      Node parent = node.parent!;
      Node grandparent = parent.parent!;
      if (parent == grandparent.left) {
        Node? uncle = grandparent.right;
        if (uncle != null && uncle.color == NodeColor.red) {
          parent.color = NodeColor.black;
          uncle.color = NodeColor.black;
          grandparent.color = NodeColor.red;
          node = grandparent;
        } else {
          if (node == parent.right) {
            node = parent;
            _rotateLeft(node);
          }
          parent.color = NodeColor.black;
          grandparent.color = NodeColor.red;
          _rotateRight(grandparent);
        }
      } else {
        Node? uncle = grandparent.left;
        if (uncle != null && uncle.color == NodeColor.red) {
          parent.color = NodeColor.black;
          uncle.color = NodeColor.black;
          grandparent.color = NodeColor.red;
          node = grandparent;
        } else {
          if (node == parent.left) {
            node = parent;
            _rotateRight(node);
          }
          parent.color = NodeColor.black;
          grandparent.color = NodeColor.red;
          _rotateLeft(grandparent);
        }
      }
    }
    root!.color = NodeColor.black;
  }

  // Left rotation
  void _rotateLeft(Node node) {
    Node temp = node.right!;
    node.right = temp.left;
    if (temp.left != null) {
      temp.left!.parent = node;
    }
    temp.parent = node.parent;
    if (node.parent == null) {
      root = temp;
    } else if (node == node.parent!.left) {
      node.parent!.left = temp;
    } else {
      node.parent!.right = temp;
    }
    temp.left = node;
    node.parent = temp;
  }

  // Right rotation
  void _rotateRight(Node node) {
    Node temp = node.left!;
    node.left = temp.right;
    if (temp.right != null) {
      temp.right!.parent = node;
    }
    temp.parent = node.parent;
    if (node.parent == null) {
      root = temp;
    } else if (node == node.parent!.right) {
      node.parent!.right = temp;
    } else {
      node.parent!.left = temp;
    }
    temp.right = node;
    node.parent = temp;
  }

  // Find the node with the minimum value in the tree
  Node _minimum(Node node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node;
  }

  // Replace one subtree as a child of its parent with another subtree
  void _replaceNode(Node u, Node? v) {
    if (u.parent == null) {
      root = v;
    } else if (u == u.parent!.left) {
      u.parent!.left = v;
    } else {
      u.parent!.right = v;
    }
    if (v != null) {
      v.parent = u.parent;
    }
  }

  // Fix the Red-Black Tree after deletion
  void _fixDeletion(Node node) {
    while (node != root && node.color == NodeColor.black) {
      if (node == node.parent!.left) {
        Node sibling = node.parent!.right!;
        if (sibling.color == NodeColor.red) {
          sibling.color = NodeColor.black;
          node.parent!.color = NodeColor.red;
          _rotateLeft(node.parent!);
          sibling = node.parent!.right!;
        }
        if ((sibling.left == null || sibling.left!.color == NodeColor.black) &&
            (sibling.right == null || sibling.right!.color == NodeColor.black)) {
          sibling.color = NodeColor.red;
          node = node.parent!;
        } else {
          if (sibling.right == null || sibling.right!.color == NodeColor.black) {
            if (sibling.left != null) sibling.left!.color = NodeColor.black;
            sibling.color = NodeColor.red;
            _rotateRight(sibling);
            sibling = node.parent!.right!;
          }
          sibling.color = node.parent!.color;
          node.parent!.color = NodeColor.black;
          if (sibling.right != null) sibling.right!.color = NodeColor.black;
          _rotateLeft(node.parent!);
          node = root!;
        }
      } else {
        Node sibling = node.parent!.left!;
        if (sibling.color == NodeColor.red) {
          sibling.color = NodeColor.black;
          node.parent!.color = NodeColor.red;
          _rotateRight(node.parent!);
          sibling = node.parent!.left!;
        }
        if ((sibling.left == null || sibling.left!.color == NodeColor.black) &&
            (sibling.right == null || sibling.right!.color == NodeColor.black)) {
          sibling.color = NodeColor.red;
          node = node.parent!;
        } else {
          if (sibling.left == null || sibling.left!.color == NodeColor.black) {
            if (sibling.right != null) sibling.right!.color = NodeColor.black;
            sibling.color = NodeColor.red;
            _rotateLeft(sibling);
            sibling = node.parent!.left!;
          }
          sibling.color = node.parent!.color;
          node.parent!.color = NodeColor.black;
          if (sibling.left != null) sibling.left!.color = NodeColor.black;
          _rotateRight(node.parent!);
          node = root!;
        }
      }
    }
    node.color = NodeColor.black;
  }

  // Delete a node from the Red-Black Tree
  void delete(int data) {
    Node? node = _search(root, data);
    if (node == null) return;

    Node? replacement = node;
    NodeColor originalColor = replacement.color;
    Node? child;
    if (node.left == null) {
      child = node.right;
      _replaceNode(node, node.right);
    } else if (node.right == null) {
      child = node.left;
      _replaceNode(node, node.left);
    } else {
      replacement = _minimum(node.right!);
      originalColor = replacement.color;
      child = replacement.right;
      if (replacement.parent == node) {
        if (child != null) {
          child.parent = replacement;
        }
      } else {
        _replaceNode(replacement, replacement.right);
        replacement.right = node.right;
        replacement.right!.parent = replacement;
      }
      _replaceNode(node, replacement);
      replacement.left = node.left;
      replacement.left!.parent = replacement;
      replacement.color = node.color;
    }
    if (originalColor == NodeColor.black) {
      _fixDeletion(child!);
    }
  }

  // Search for a node in the Red-Black Tree
  Node? _search(Node? root, int value) {
    if (root == null) return null;
    if (value < root.data) return _search(root.left, value);
    if (value > root.data) return _search(root.right, value);
    return root;
  }
}
