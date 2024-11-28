import 'dart:typed_data';
import 'package:fluent_ui/fluent_ui.dart';

typedef ApagarImagemCallback = void Function();

class ImagemW {
  int id;
  String? nome;
  Uint8List? bytes;
  int largura = 0;
  int altura = 0;
  TextEditingController? legendaController;

  ImagemW(this.id);

  String get legenda => legendaController?.text ?? '';
  bool get imagemVazia =>  bytes == null;

  @override
  String toString() {
    return 'ImagemW{id: $id, nome: $nome, dimensões: ${largura}px x ${altura}px, legenda: $legenda}';
  }
}