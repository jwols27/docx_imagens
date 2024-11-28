import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:docx_imagens/functions/transformador.dart';
import 'package:docx_imagens/classes/ImagemW.dart';
import 'package:docx_imagens/components/command_bar.dart';
import 'package:docx_imagens/components/image_picker.dart';

class GridPaneW extends StatefulWidget {
  const GridPaneW({super.key});

  @override
  State<GridPaneW> createState() => _GridPaneWState();
}

class _GridPaneWState extends State<GridPaneW> {
  TextEditingController textoInicialController = TextEditingController();
  List<ImagemW> imagens = List.generate(9, (i) => ImagemW(i));

  List<TrackSize> numColumns = List.generate(3, (_) => auto);
  List<TrackSize> numRows = List.generate(3, (_) => auto);

  int _chave = 0; // Reconstruir KeyedSubtree quando a grade muda

  void alterarGrade(int l, int h) {
    setState(() {
      numColumns = List.generate(l, (_) => auto);
      numRows = List.generate(h, (_) => auto);
      imagens = List.generate(l * h, (i) => ImagemW(i));
      textoInicialController.clear();
      _chave = _chave + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CommandBarW(
              alterarGradeCallback: (int l, int h) => alterarGrade(l, h),
              converterCallback: () => transformarDocx(textoInicialController.text, imagens)
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                    child: InfoLabel(
                      label: 'Texto inicial:',
                      child: Container(
                        constraints: BoxConstraints(maxWidth: numColumns.length == 2 ? 784 : 1200),
                        margin: const EdgeInsets.only(top: 4),
                        child: TextBox(
                          controller: textoInicialController,
                          placeholder:
                          'Digite o texto que aparecerá antes das imagens',
                          maxLines: null,
                          expands: false,
                        ),
                      ),
                    ),
                ),
                const SizedBox(width: 16, height: 16),
                KeyedSubtree(
                  key: ValueKey<int>(_chave),
                  child: Card(
                    child: LayoutGrid(
                        gridFit: GridFit.loose,
                        columnSizes: numColumns,
                        rowSizes: numRows,
                        rowGap: 24,
                        columnGap: 48,
                        children: [
                          ...List.generate(imagens.length, (index) {
                            return ImagePickerW(key: Key('$index-img'),
                                imagem: imagens[index]);}),
                        ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
