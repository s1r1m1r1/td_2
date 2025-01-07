import 'package:flame/camera.dart';
import 'package:flame/components.dart';

extension ViewfinderExt on Viewfinder {
  void moveTop(double displacement) {
    position = position.translated(0, displacement * -1);
  }

  void moveRight(double displacement) {
    position = position.translated(displacement, 0);
  }

  void moveLeft(double displacement) {
    position = position.translated(displacement * -1, 0);
  }

  void moveDown(double displacement) {
    position = position.translated(0, displacement);
  }

  void moveUp(double displacement) {
    position = position.translated(displacement * -1, 0);
  }
}
