import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourseCard extends StatefulWidget {
  final String courseName;
  final String price;
  final String description;
  final String rating;
  final String reviews;
  final Color backgroundColor;
  final String imageUrl;

  const CourseCard({
    super.key,
    required this.courseName,
    required this.price,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    this.backgroundColor = Colors.white,
  });

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSection(),
              const SizedBox(height: 12),
              _buildTextSection(),
              const SizedBox(height: 8),
              _buildPriceSection(),
              const SizedBox(height: 8),
              _buildDescriptionSection(),
              const SizedBox(height: 8),
              _buildRatingSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: FaIcon(
                isFavorite
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection() {
    return AutoSizeText(
      widget.courseName,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      maxLines: 1,
    );
  }

  Widget _buildPriceSection() {
    return AutoSizeText(
      "₺ ${widget.price}",
      style: TextStyle(
        color: Colors.lightBlue.shade700,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      maxLines: 1,
    );
  }

  Widget _buildDescriptionSection() {
    return AutoSizeText(
      widget.description.length > 50
          ? "${widget.description.substring(0, 50)}..."
          : widget.description,
      style: TextStyle(color: Colors.grey[600], fontSize: 14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(Icons.star, color: Colors.yellow[700], size: 16);
          }),
        ),
        const SizedBox(width: 4),
        AutoSizeText(
          "${widget.rating} (${widget.reviews})",
          style: const TextStyle(color: Colors.grey, fontSize: 14),
          maxLines: 1,
        ),
      ],
    );
  }
}
