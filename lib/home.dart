import 'package:fluent_ui/fluent_ui.dart';

import 'package:docx_imagens/panes/grid_pane.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.modoEscuro, required this.onToggleModoEscuro});

  final bool modoEscuro;
  final ValueChanged<bool> onToggleModoEscuro;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int topIndex = 0;

  @override
  Widget build(BuildContext context) {

    return NavigationView(
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: PaneDisplayMode.top,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            body: const GridPaneW(),
          ),
          //PaneItemSeparator(),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Configurações'),
            body: Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Modo claro/escuro',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 8),
                    ToggleSwitch(
                      checked: widget.modoEscuro,
                      content: widget.modoEscuro
                          ? const Icon(FluentIcons.circle_fill)
                          : const Icon(FluentIcons.light),
                      onChanged: widget.onToggleModoEscuro,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
