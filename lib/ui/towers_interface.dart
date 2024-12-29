import 'package:bonfire/bonfire.dart';
import 'draggable_button.dart';

class TowersInterface extends GameInterface {
  static const followerWidgetTestId = 'BUTTON';

  @override
  void onMount() async {
    await add(DraggableButton(Vector2(200, 20)));
    await add(DraggableButton(Vector2(250, 20)));
    await add(DraggableButton(Vector2(300, 20)));
    await add(DraggableButton(Vector2(350, 20)));

    super.onMount();
  }
}
