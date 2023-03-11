import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmployeeTile extends StatefulWidget {
  const EmployeeTile({
    Key? key,
    required this.photoUrl,
    required this.jobId,
    required this.name,
    required this.bioJoke,
    required this.onTap,
  }) : super(key: key);

  final String photoUrl;
  final String jobId;
  final String name;
  final String bioJoke;
  final VoidCallback onTap;


  @override
  State<EmployeeTile> createState() => _EmployeeTileState();
}

class _EmployeeTileState extends State<EmployeeTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SingleChildScrollView(
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: CachedNetworkImageProvider(widget.photoUrl),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  widget.jobId,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.bioJoke,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
