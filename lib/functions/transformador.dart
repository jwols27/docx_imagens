import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:docx_template/docx_template.dart';
import 'package:path_provider/path_provider.dart';

import 'package:docx_imagens/classes/ImagemW.dart';

void transformarDocx(String? textoInicial, List<ImagemW> imagens) async {
  String gradeTemplate = '';

  if (imagens.length == 4) {
    gradeTemplate = 'lib/assets/template2x2.docx';
  } else if (imagens.length == 9) {
    gradeTemplate = 'lib/assets/template3x3.docx';
  } else {
    throw UnimplementedError('Grade não existe');
  }

  final data = await rootBundle.load(gradeTemplate);
  final bytes = data.buffer.asUint8List();

  final docx = await DocxTemplate.fromBytes(bytes);

  Content c = Content();

  c.add(TextContent('texto1', textoInicial ?? ''));

  for (int i = 1; i <= imagens.length; i++) {
    if (imagens[i - 1].bytes != null) {
      c.add(ImageContent('img$i', imagens[i - 1].bytes));
    }
    c.add(TextContent('leg$i', imagens[i - 1].legenda));
  }

  final d = await docx.generate(c, tagPolicy: TagPolicy.saveNullified);

  if (d != null) {
    final docs = await getApplicationDocumentsDirectory();

    final pasta = Directory('${docs.path}/Docx Imagens');
    if (!await pasta.exists()) {
      await pasta.create(recursive: true);
    }

    final dataHora = DateTime.now();
    final dataHoraFormatado = DateFormat('yyyy-MM-dd_HH-mm-ss').format(dataHora);
    final arquivo = 'documento_$dataHoraFormatado.docx';

    final of = File('${pasta.path}/$arquivo');
    await of.writeAsBytes(d);
  }
}