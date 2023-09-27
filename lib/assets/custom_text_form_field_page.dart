
// custom_text_form_field_page.dart
import 'package:flutter/material.dart';


// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}

// Custom Text Form Field widget
class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String errorMessage;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.errorMessage,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onTap,
  }) : super(key: key);

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isValid = true;

  void setValid(bool isValid) {
    setState(() => _isValid = isValid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 300, height: 40,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: (value) {
          setState(() => _isValid = value.isNotEmpty);
        },
        style: const TextStyle(
          color: Colors.white, fontSize: 18, fontFamily: 'Nunito', fontWeight: FontWeight.bold,
        ),

        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: _isValid ? widget.hintText : widget.errorMessage,
          hintStyle: TextStyle(
            color: _isValid ? Colors.white : const Color(0xFF003366),
            fontSize: 12, fontFamily: 'Nunito',
          ),
          fillColor: const Color(0xFF00a896),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
        ),
      ),
    );
  }
}



