
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
  get camp => null;


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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10.0,bottom:5.0 ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: defaultTextfield(
                  nameCamp: S.of(context).affair,
                  controllerCamp: widget.camp,
                  campOld: '',
                ),

              ),
              const SizedBox(width: 8),
              materialButton(
                 nameAction: S.of(context).attach,
                 function: () async {
                   _pickFile(context);
                 },
              ),
            ],
          ),
        ),

        // Lista de adjuntos
        if (widget.attachments != null && widget.attachments!.isNotEmpty)
          SizedBox(
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.attachments!.length,
              itemBuilder: (context, index) {
                final file = widget.attachments![index];
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Chip(
                    label: Text(file.path.split('/').last),
                    onDeleted: () {
                      setState(() {
                        widget.attachments!.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );


  }
}