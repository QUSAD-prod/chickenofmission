import 'package:chickenofmission/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  runApp(
    ProviderScope(
      child: Sizer(
        builder: (context, orientation, screenType) => App(),
      ),
    ),
  );
}
