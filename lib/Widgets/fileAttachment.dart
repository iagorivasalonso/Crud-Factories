
import 'dart:io';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:file_picker/file_picker.dart' show FilePickerResult, FilePicker, FileType;
import 'package:flutter/material.dart' hide IconButton;

import '../Backend/Global/variables.dart';
import 'materialButton.dart';

class Fileattachment extends StatefulWidget {

  final TextEditingController camp;
  final List<String>? allowedExtensions;
  final bool multiple;
  final List<File>? attachments;
  final File? singleAttachment;
  final void Function(List<File>)? onFilesChanged;
  final void Function(File?)? onFileChange;

  const Fileattachment({
    super.key,
    required this.camp,
    this.allowedExtensions,
    this.multiple = true,
    this.attachments,
    this.singleAttachment,
    this.onFileChange,
    this.onFilesChanged
  });

  @override
  State<Fileattachment> createState() => _FileattachmentState();
}

class _FileattachmentState extends State<Fileattachment> {

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      dialogTitle: S
          .of(context)
          .select_file,
      type: widget.allowedExtensions != null
          ? FileType.custom
          : FileType.any,
      allowedExtensions: widget.allowedExtensions,
      allowMultiple: widget.multiple,
    );

    if (result == null) return;

    if (widget.multiple) {
      final files = result.paths.map((p) => File(p!)).toList();
      widget.onFilesChanged?.call(files);
    }
    else {
      final file = File(result.files.single.path!);
      widget.onFileChange?.call(file);
    }
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // importante
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 👈 alineamos los hijos a la izquierda
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 12),
                      child:defaultTextfield(
                        nameCamp: S.of(context).affair,
                        controllerCamp: widget.camp,
                        campOld: '',
                      ),

                  ),
                  const SizedBox(height: 6),
                  // 👇 fila horizontal de archivos justo debajo del TextField
                  if (widget.attachments != null && widget.attachments!.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // el Row solo ocupa el ancho de los chips
                        children: List.generate(widget.attachments!.length, (index) {
                          final file = widget.attachments![index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  file.path.split('/').last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.attachments!.removeAt(index);
                                      widget.onFilesChanged?.call(widget.attachments!);
                                    });
                                  },
                                  child: const Icon(Icons.close, size: 15),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter, // 👈 pega al tope del Row
                child: materialButton(
                  nameAction: S.of(context).attach,
                  function: () async {
                    _pickFile(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}