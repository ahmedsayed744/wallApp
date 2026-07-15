
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/generated/l10n.dart';

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({
    super.key,
    required this.noteController,
  });

  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22).r,
      child: TextField(
        controller: noteController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.4, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.4, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.4, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          hintText: S.of(context).noteHint,
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 50,
          ),
        ),
      ),
    );
  }
}
