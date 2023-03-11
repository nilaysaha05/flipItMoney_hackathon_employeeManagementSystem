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
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(widget.photoUrl),
              ),
            ),
            Container(
              height: 100,
              width: 250,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JOB-Id : ${widget.jobId}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Name : ${widget.name}',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'bioJoke : ${widget.bioJoke}',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
