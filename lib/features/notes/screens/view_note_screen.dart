import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';

class ViewNoteScreen extends StatelessWidget {
  final NoteController controller = Get.find();
  final int index = Get.arguments['index'];
  final NoteModel note = Get.arguments['note'];

  final titleC = TextEditingController();
  final contentC = TextEditingController();

  ViewNoteScreen({super.key}) {
    titleC.text = note.title;
    contentC.text = note.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit_note'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (titleC.text.trim().isEmpty &&
                  contentC.text.trim().isEmpty) {
                Get.snackbar(
                  'oops'.tr,
                  'empty_note_warning'.tr,
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }
              controller.editNote(index, titleC.text.trim(), contentC.text.trim());
              Get.back();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: InputDecoration(
                hintText: 'note_title_hint'.tr,
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: contentC,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'note_content_hint'.tr,
                  border: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}