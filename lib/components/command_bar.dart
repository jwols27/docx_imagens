import 'package:fluent_ui/fluent_ui.dart';

typedef AlterarGradeCallback = void Function(int l, int h);
typedef LocalCallback = void Function();

class CommandBarW extends StatefulWidget {
  const CommandBarW({super.key, required this.alterarGradeCallback, required this.converterCallback});

  final AlterarGradeCallback alterarGradeCallback;
  final LocalCallback converterCallback;

  @override
  State<CommandBarW> createState() => _CommandBarWState();
}

class _CommandBarWState extends State<CommandBarW> {
  int larguraAtual = 3;
  int alturaAtual = 3;

  void alterarGrade(int l, int h) {
    if (larguraAtual != l || alturaAtual != h) {
      widget.alterarGradeCallback(l, h);
      larguraAtual = l;
      alturaAtual = h;
    }
  }

  void converter() {
    widget.converterCallback();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Container(
      color: theme.brightness == Brightness.dark ? theme.accentColor : theme.cardColor,
      padding: const EdgeInsets.all(4),
      child: CommandBar(
        overflowBehavior: CommandBarOverflowBehavior.noWrap,
        primaryItems: [
          CommandBarBuilderItem(
            builder: (context, mode, w) => Tooltip(
              message: "Alterar a grade",
              child: w,
            ),
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.grid_view_small),
              label: const Text('Grade 2x2'),
              onPressed: () => alterarGrade(2, 2),
            ),
          ),
          CommandBarBuilderItem(
            builder: (context, mode, w) => Tooltip(
              message: "Alterar a grade",
              child: w,
            ),
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.grid_view_small),
              label: const Text('Grade 3x3'),
              onPressed: () => alterarGrade(3, 3),
            ),
          ),
          CommandBarBuilderItem(
            builder: (context, mode, w) => Tooltip(
              message: "Transformar em .docx",
              child: w,
            ),
            wrappedItem: CommandBarButton(
              icon: const Icon(FluentIcons.text_document_settings),
              label: const Text('Transformar'),
              onPressed: converter,
            ),
          ),
        ],
      ),
    );
  }
}
