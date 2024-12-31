// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:bonfire/bonfire.dart';
// import 'package:logging/logging.dart';

// import 'package:td_2/game_core/controller/game_controller.dart';
// import 'package:td_2/game_core/controller/game_event.dart';

// final _log = Logger(WaveSpawnController.loggerName);

// class WaveSpawnController extends GameComponent {
//   static const loggerName = 'WaveSpawnController';
//   WaveSpawnController({
//     required this.interval,
//     required this.waveIndex,
//   });
//   final int interval;
//   int waveIndex;

//   @override
//   void update(double dt) {
//     _processEnemySpawn(dt);
//     super.update(dt);
//   }

//   void _processEnemySpawn(double dt) {
//     if (checkInterval('check next wave', interval, dt)) {
//       _log.info("waveInterval checked");
//       GameController.event(GameEvent.spawnOne(type));
//     }
//   }

//   WaveSpawnController copyWith({
//     int? interval,
//   }) {
//     return WaveSpawnController(
//       interval: interval ?? this.interval,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'interval': interval,
//     };
//   }

//   static WaveSpawnController? fromMap(Map<dynamic, dynamic>? map) {
//     if (map == null) {
//       return null;
//     }
//     return WaveSpawnController(
//       interval: DartDynamic.asrInt(map['interval']),
//     );
//   }

//   String toJson() => JsonSync.encode(toMap());

//   static WaveSpawnController? fromJson(String source) =>
//       WaveSpawnController.fromMap(
//           DartDynamic.asMap<dynamic, dynamic>(JsonSync.decode(source)));

//   @override
//   String toString() => 'WaveSpawnController(interval: $interval)';

//   @override
//   bool operator ==(covariant WaveSpawnController other) {
//     if (identical(this, other)) return true;

//     return other.interval == interval;
//   }

//   @override
//   int get hashCode => interval.hashCode;
// }
