import 'package:chickenofmission/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'core/models/board_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());
  final settingsBox = await Hive.openBox<int>('settings');
  GetIt.I.registerSingleton(settingsBox);

  await SoLoud.instance.init(
    automaticCleanup: true,
    channels: Channels.mono,
  );
  final audioSource = await SoLoud.instance.loadAsset('assets/sounds/move.mp3');
  GetIt.I.registerSingleton(audioSource);

  runApp(
    ProviderScope(
      child: Sizer(
        builder: (context, orientation, screenType) => App(),
      ),
    ),
  );
}
