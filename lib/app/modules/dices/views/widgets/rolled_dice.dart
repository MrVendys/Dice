import 'package:flutter/material.dart'; 
 
class RolledDice extends StatelessWidget { 
  final int count; 
  final GestureTapCallback? onTap; 
 
  const RolledDice({ 
    Key? key, 
    required this.count, 
    this.onTap, 
  }) : super(key: key); 
 
  @override 
  Widget build(BuildContext context) { 
    return Padding( 
      padding: const EdgeInsets.all(8.0), 
      child: SizedBox( 
        height: 60, 
        width: 60, 
        child: (onTap != null) 
            ? InkWell( 
                onTap: onTap, 
                child: Image.asset('assets/dices/dice_$count.png'), 
              ) 
            : Image.asset('assets/dices/dice_$count.png'), 
      ),  
    ); 
  } 
} 
