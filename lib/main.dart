import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'package:docx_imagens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await SystemTheme.accentColor.load();
  SystemTheme.onChange.listen((color) {
    debugPrint('Accent color changed to ${color.accent}');
  });

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1600, 900),
    minimumSize: Size(1300, 500),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });

  runApp(const Aplicativo());
}

class Aplicativo extends StatefulWidget {
  const Aplicativo({super.key});

  @override
  State<Aplicativo> createState() => _AplicativoState();
}

class _AplicativoState extends State<Aplicativo> {
  bool modoEscuro = false;

  @override
  void initState() {
    super.initState();
    modoEscuro = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  void toggleModoEscuro(bool novoModo) {
    setState(() {
      modoEscuro = novoModo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Imagens .docx",
      home: HomePage(modoEscuro: modoEscuro, onToggleModoEscuro: toggleModoEscuro),
      debugShowCheckedModeBanner: false,
      themeMode: modoEscuro ? ThemeMode.dark : ThemeMode.light,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.standard,
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      theme: FluentThemeData(
        visualDensity: VisualDensity.standard,
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      locale: const Locale("pt", "BR"),
      supportedLocales: const [
        Locale("pt", "BR"),
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: NavigationPaneTheme(
            data: const NavigationPaneThemeData(),
            child: child!,
          ),
        );
      },
    );
  }
}