import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:docx_imagens/classes/ImagemW.dart';


class ImagePickerW extends StatefulWidget {
  const ImagePickerW({super.key, required this.imagem});

  final ImagemW imagem;

  @override
  State<ImagePickerW> createState() => _ImagePickerWState();
}

class _ImagePickerWState extends State<ImagePickerW> {
  final double alturaView = 320.0 + 24;
  final double larguraView = 320.0 + 48;

  TextEditingController controller = TextEditingController();

  void apagarImagem() {
    setState(() {
      widget.imagem.bytes = null;
      widget.imagem.legendaController?.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    widget.imagem.legendaController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    widget.imagem.bytes = null;
    widget.imagem.legendaController?.clear();
    widget.imagem.legendaController = null;
  }

  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        withData: true,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        widget.imagem.bytes = file.bytes;
        widget.imagem.nome = file.name;
      });
      var decodedImage =
          await decodeImageFromList(await file.xFile.readAsBytes());
      widget.imagem.largura = decodedImage.width;
      widget.imagem.altura = decodedImage.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: larguraView,
          height: alturaView,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: theme.brightness == Brightness.light
                ? Border.all(
                    color: theme.micaBackgroundColor, // Border color
                    width: 2.0, // Border width
                  )
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.imagem.imagemVazia
              ? const Text('Vazio')
              : Image.memory(widget.imagem.bytes!),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: larguraView,
          child: Row(
            children: [
              Expanded(
                child: theme.brightness == Brightness.light
                    ? Button(
                        child: const Text('Enviar imagem'),
                        onPressed: () => uploadImage(),
                      )
                    : FilledButton(
                        child: const Text('Enviar imagem'),
                        onPressed: () => uploadImage(),
                      ),
              ),
              if (!widget.imagem.imagemVazia) ...[
                const SizedBox(width: 8),
                Button(
                  onPressed: apagarImagem,
                  child: const Icon(FluentIcons.delete, size: 20.0),
                ),
              ]
            ],
          ),
        ),
        if (!widget.imagem.imagemVazia) ...[
          SizedBox(
            width: larguraView,
            child: TextBox(
              placeholder: "Legenda",
              controller: controller,
            ),
          ),
        ] else ...[
          const SizedBox(height: 32)
        ]
      ],
    ).withGridPlacement(columnSpan: 1, rowSpan: 1);
  }
}
