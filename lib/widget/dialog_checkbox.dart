// 单独封装一个内部管理选中状态的复选框组件
import 'package:flutter/material.dart';

class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key? key,
    this.value,
    required this.onChanged,
    this.activeColor,
    this.side
  });

  final ValueChanged<bool?> onChanged;
  final bool? value;
  final Color? activeColor;
  final BorderSide? side;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      activeColor: widget.activeColor,
      side: widget.side,
      onChanged: (v) {
        //将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          //更新自身选中状态
          value = v;
        });
      },
    );
  }
}