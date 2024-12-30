import 'dart:math';

import 'package:astar_dart/astar_dart.dart';
import 'package:logging/logging.dart';

final _log = Logger(AstarController.loggerName);

final astarController = AstarController();

class AstarController {
  static const loggerName = 'AstarMixin';
  late final Array2d<Barrier> _barriers;
  late final Array2d<int> _grounds;
  late final AStarSquareGrid _astar;
  bool shouldUpdate = true;

  void init(int width, int height) {
    _barriers = Array2d(width, height, defaultValue: Barrier.pass);
    _grounds = Array2d(width, height, defaultValue: 1);
    _astar = AStarSquareGrid(
      rows: width,
      columns: height,
      diagonalMovement: DiagonalMovement.manhattan,
      barriers: _barriers,
      grounds: _grounds,
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
    _barriers[x][y] = Barrier.block;
  }

  void removeBarrier(int x, int y) {
    _barriers[x][y] = Barrier.pass;
  }

  Future<List<Point<int>>> findPath({
    required Point<int> start,
    required Point<int> end,
  }) async {
    if (shouldUpdate) {
      _astar.calculateGrid();
      shouldUpdate = false;
    }
    // end , path , begin
    final path = await _astar.findPath(start: start, end: end);
    return path.toPointList();
  }
}
