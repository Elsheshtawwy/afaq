import 'package:afaq/models/InstituteModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class InstituteCard extends StatelessWidget {
  final InstituteModel institute;

  const InstituteCard({
    super.key,
    required this.institute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 90,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: institute.logoUrl != null
                      ? CachedNetworkImageProvider(institute.logoUrl!)
                      : const AssetImage('assets/default_logo.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  institute.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  institute.address,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    const SizedBox(width: 3),
                    
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  institute.accreditation ?? 'No accreditation info',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
