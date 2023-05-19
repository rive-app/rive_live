import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive_overlay_app/models/animations_data.dart';
import 'package:rive_overlay_app/pages/home_page.dart';
import 'package:rive_overlay_app/theme.dart';

/// This make the winow transparent on MacOS.
Future<void> _setupWindowTransparancy() async {
  await Window.initialize();
  // Window.makeWindowFullyTransparent();
  await Window.setWindowBackgroundColorToClear();
  // await Window.makeTitlebarTransparent();
  await Window.addEmptyMaskImage();
  await Window.disableShadow();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupWindowTransparancy();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [AnimationDataSchema],
    directory: dir.path,
  );

  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isar,
  });

  final Isar isar;

  ThemeData theme() {
    var baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: RiveColors().blue,
        background: RiveColors().grey1D,
        surface: RiveColors().grey11,
      ),
      visualDensity: VisualDensity.compact,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: isar,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const HomePage(),
      ),
    );
  }
}
