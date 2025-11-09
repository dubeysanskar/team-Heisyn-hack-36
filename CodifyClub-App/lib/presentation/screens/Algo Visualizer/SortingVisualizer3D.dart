import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as vmath;

class SortingVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SortingVisualizer(),
    );
  }
}

class SortingVisualizer extends StatefulWidget {
  @override
  _SortingVisualizerState createState() => _SortingVisualizerState();
}

class _SortingVisualizerState extends State<SortingVisualizer> {
  List<int> array = [];
  List<Object> cubes = [];
  bool isSorting = false;
  Scene? scene;
  String sortingStep = '';
  List<int> highlightedIndexes = [];

  @override
  void initState() {
    super.initState();
    _generateRandomArray(10); // Generate an array of 10 random numbers
  }

  void _generateRandomArray(int length) {
    setState(() {
      array = List<int>.generate(length, (index) => Random().nextInt(100));
      cubes.clear(); // Clear the old cubes
      // Add the new cubes to the list
      for (int i = 0; i < array.length; i++) {
        cubes.add(Object(
          position: vmath.Vector3(i.toDouble() * 2.0, 0, 0),
          scale: vmath.Vector3(1, array[i].toDouble() / 10, 1),
          fileName: 'assets/cube.obj',
        ));
      }
    });

    // Now update the scene with the new cubes
    if (scene != null) {
      scene!.world.children.clear();  // Clear old cubes in the scene
      // Add new cubes to the scene
      for (var cube in cubes) {
        scene!.world.add(cube);
      }
    }
  }

  Future<void> _bubbleSort() async {
    setState(() {
      isSorting = true;
    });

    for (int i = 0; i < array.length - 1; i++) {
      for (int j = 0; j < array.length - i - 1; j++) {
        setState(() {
          highlightedIndexes = [j, j + 1]; // Highlight the two elements being compared
          sortingStep = 'Comparing ${array[j]} and ${array[j + 1]}';
        });

        if (array[j] > array[j + 1]) {
          // Swap the elements in the array
          int temp = array[j];
          array[j] = array[j + 1];
          array[j + 1] = temp;

          // Swap the cubes' positions
          setState(() {
            _swapCubes(j, j + 1);
          });

          // Wait for a short duration to visualize the swap
          await Future.delayed(Duration(milliseconds: 500));
        }

        // Reset the highlighted elements after comparison
        await Future.delayed(Duration(milliseconds: 300));
        setState(() {
          highlightedIndexes = [];
        });
      }
    }

    setState(() {
      sortingStep = 'Sorting Complete!';
      isSorting = false;
    });
  }

  void _swapCubes(int indexA, int indexB) {
    // Swap the cubes' position and scale
    var temp = cubes[indexA];
    cubes[indexA] = Object(
      position: vmath.Vector3(indexA.toDouble() * 2.0, 0, 0),
      scale: vmath.Vector3(1, array[indexA].toDouble() / 10, 1),
      fileName: 'assets/cube.obj',
    );
    cubes[indexB] = Object(
      position: vmath.Vector3(indexB.toDouble() * 2.0, 0, 0),
      scale: vmath.Vector3(1, array[indexB].toDouble() / 10, 1),
      fileName: 'assets/cube.obj',
    );

    // Update the scene with the swapped cubes
    scene!.world.children[indexA] = cubes[indexA];
    scene!.world.children[indexB] = cubes[indexB];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D Sorting Visualizer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Cube(
              onSceneCreated: (Scene createdScene) {
                scene = createdScene;
                // Initially, add the cubes to the scene
                for (var cube in cubes) {
                  scene!.world.add(cube);
                }
              },
            ),
          ),
          // Display the array in a visual manner with highlighted containers
          Expanded(
            child: Wrap(
              spacing: 2, // Horizontal spacing between items
              children: List.generate(array.length, (index) {
                bool isHighlighted = highlightedIndexes.contains(index);
                return Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: isHighlighted ? Colors.red : Colors.blue, // Change color when highlighted
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                array[index].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      index.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: isSorting ? null : _bubbleSort,
              child: Text(isSorting ? 'Sorting...' : 'Start Bubble Sort'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: isSorting ? null : () => _generateRandomArray(10),
              child: Text('Generate New Array'),
            ),
          ),
          // Show sorting steps
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sortingStep,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
