import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<CustomDropdownMenuItem> items;

  const CustomDropdownMenu({Key? key, required this.items}) : super(key: key);

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _isExpanded = !_isExpanded);
          },
          child: Container(
            width: 50,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMenuItem(),
                SizedBox(height: 5),
                _buildMenuItem(),
                SizedBox(height: 5),
                _buildMenuItem(),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: widget.items,
            ),
          ),
      ],
    );
  }

  Widget _buildMenuItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('•', style: TextStyle(fontSize: 30, color: Colors.black)),
        SizedBox(width: 5),
        Container(
          width: 25,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CustomDropdownMenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration:
        BoxDecoration(borderRadius:
        BorderRadius.circular(25)),
        child:
        Row(children:[
          Icon(icon, color :
          Colors.black),
          SizedBox(width :
          10),
          Text(text, style :
          TextStyle(color :
          Color(0xFF00a896), fontFamily :
          'Nunito', fontWeight :
          FontWeight.bold))
        ]),
      ),
    );
  }
}
