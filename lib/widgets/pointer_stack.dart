import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class PointerStack extends StatelessWidget {
  PointerStack({super.key});

  final childKeys = <GlobalKey>[];
  final nKey = GlobalKey();

  bool isContains(Offset point, GlobalKey key) {
    // if (!mounted) return;
    final ctx = key.currentContext;
    if (ctx == null) return false;
    final renderBox = ctx.findRenderObject() as RenderBox?;
    if (renderBox == null) return false;
    final size = ctx.size;
    if (size == null) return false;
    final position = renderBox.localToGlobal(Offset.zero);
    final rect =
        Rect.fromLTWH(position.dx, position.dy, size.width, size.height);
    final contains = rect.contains(point);
    return contains;
  }

  @override
  Widget build(BuildContext context) {
    final n = ValueNotifier(Offset(100, 100));
    final n2 = ValueNotifier(Offset(200, 200));
    return Listener(
      onPointerMove: (details) {
        final nResult = isContains(details.position, nKey);
        if (nResult) {
          n.value = n.value + details.delta;
        }
        debugPrint('result x $nResult');
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListenableBuilder(
            listenable: n,
            builder: (context, _) {
              return Positioned(
                left: n.value.dx,
                top: n.value.dy,
                key: nKey,
                height: 200,
                width: 100,
                child: Text(
                  'DRAG ME',
                  style: TextStyle(color: Colors.green),
                ),
              );
            },
          ),
          ListenableBuilder(
            listenable: n2,
            builder: (context, _) {
              return Positioned(
                left: n2.value.dx,
                top: n2.value.dy,
                height: 200,
                width: 200,
                child: Text(
                  'DRAG ME',
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          )
          // MenuItem()
        ],
      ),
    );
  }
}

// class MenuItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final n = ValueNotifier(Offset(100, 100));
//     return GestureDetector(
//         onPanUpdate: (details) {
//           n.value = n.value + details.delta;
//         },
//         child: ListenableBuilder(
//             listenable: n,
//             builder: (context, _) {
//               return Positioned(
//                   left: n.value.dx,
//                   top: n.value.dy,
//                   height: 200,
//                   width: 100,
//                   child: Text(
//                     'DRAG ME',
//                     style: TextStyle(color: Colors.green),
//                   ));
//             }));
//   }
// }
