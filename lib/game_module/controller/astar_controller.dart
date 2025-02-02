import 'dart:math';

import 'package:astar_dart/astar_dart.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:logging/logging.dart';

final _log = Logger(AstarController.loggerName);

final astarController = AstarController();

class AstarController {
  static const loggerName = 'AstarMixin';
  late final AStarManhattan _astar;
  bool shouldUpdate = true;

  void init(int width, int height) {
    _astar = AStarManhattan(
      rows: width,
      columns: height,
    );
  }

  // void test() {
  //   try {
  //     init(4, 4);
  //     _barriers[0][1] = Barrier.block;
  //     // _barriers[1][1] = Barrier.block;
  //     _astar.calculateGrid();

  //     _astar
  //         .findPath(start: const Point(0, 0), end: Point(0, 2))
  //         .then((result) {
  //       // not return start point
  //       // return end point
  //       // should reversed
  //       _log.info("result ${result.toPointList().reversed}");
  //     });
  //   } catch (error, stack) {
  //     _log.warning('Not good', null, stack);
  //   }
  // }

  // void astarInit(Vector2 size) {
  //   astarMap = AStarSquareGrid(
  //       rows: size.x.toInt(),
  //       columns: size.y.toInt(),
  //       diagonalMovement: DiagonalMovement.manhattan);
  // }

  void addBarrier(int x, int y) {
    _astar.setBarrier(x: x, y: y, barrier: Barrier.block);
  }

  void clearBarriers() {
    _astar.grid.forEach((node, x, y) => node.barrier = Barrier.pass);
  }

  void addAllBarrier(List<Point<int>> barriers) {
    for (final b in barriers) {
      _astar.grid[b.x][b.y].barrier = Barrier.block;
    }
  }

  void removeBarrier(int x, int y) {
    _astar.grid[x][y].barrier = Barrier.pass;
  }

  Future<List<Point<int>>> findPath({
    required Point<int> start,
    required Point<int> end,
  }) async {
    if (shouldUpdate) {
      _astar.addNeighbors();
      shouldUpdate = false;
    }
    // end , path , begin
    final a = (x: start.x, y: start.y);
    final b = (x: end.x, y: end.y);
    final path = await _astar.findPath(start: a, end: b);
    return path.toPointList();
  }
}
