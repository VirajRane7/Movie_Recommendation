import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class modified_text extends StatelessWidget {
  // const modified_text({Key? key}) : super(key: key);
  final String text;
  final Color color;
  final double size;

  const modified_text({super.key, required this.text, required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false, style: GoogleFonts.comicNeue(
        color : color, fontSize:size
    ),
    );
  }
}
