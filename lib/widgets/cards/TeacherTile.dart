import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeacherTile extends StatefulWidget {
  final String name;
  final String rating;
  final String reviews;
  final String avatarUrl;

  const TeacherTile({
    super.key,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.avatarUrl,
  });

  @override
  _TeacherTileState createState() => _TeacherTileState();
}

class _TeacherTileState extends State<TeacherTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star,
                            color: Colors.yellow[700], size: 16);
                      }),
                    ),
                    const SizedBox(width: 4),
                    AutoSizeText(
                      "${widget.rating} (${widget.reviews})",
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: FaIcon(
              isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: isFavorite ? Colors.red : Colors.lightBlue.shade700,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }
}