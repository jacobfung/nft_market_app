import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class CommonInput extends StatefulWidget {
  final String title;
  final String hint;
  final bool isPsw;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const CommonInput({ 
    Key? key, 
    required this.title,
    required this.hint,
    this.isPsw = false,
    required this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  _CommonInputState createState() => _CommonInputState();
}

class _CommonInputState extends State<CommonInput> {

  final _focusNode = FocusNode();
  bool isFocus = false;
  bool pswVisibility = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(fontSize: 16,)),
          _input()
        ]
      )
    );
    
  }

  Widget _input() {
    final Color _gray = ColorUtil.commonGrey();
    return AnimatedContainer(
      height: 52,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 24, right: 24),
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        border: Border.all(color: ColorUtil.hexColor(isFocus ? '5d5fef' : 'eaeff3')),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Icon(widget.icon, color: _gray,),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              cursorColor: Colors.black,
              obscureText: widget.isPsw ? !pswVisibility : false,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 18)
              ),
            ),
          ),
          if (widget.isPsw) 
            GestureDetector(
              onTap: () {
                setState(() {
                  pswVisibility = !pswVisibility;
                });
              },
              child: Icon(pswVisibility ? Icons.visibility : Icons.visibility_off, color: _gray,),
            ),
        ],
      ),
    );
  }
}