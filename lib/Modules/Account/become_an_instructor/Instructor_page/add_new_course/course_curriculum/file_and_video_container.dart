import 'package:flutter/material.dart';

import '../../../../../../shared/constant.dart';

class FileAndVideoContainer extends StatefulWidget {
  final int index;
  final int sectionIndex;
  final Function(int) onEdit;
  final Function(int ) onAdd;
  final Function(int) onDelete;
  final Function(int) onDuplicate;

  FileAndVideoContainer({
    required this.index,
    required this.sectionIndex,
    required this.onEdit,
    required this.onAdd,
    required this.onDelete,
    required this.onDuplicate,
  });
  @override
  State<FileAndVideoContainer> createState() => _FileAndVideoContainerState();
}

class _FileAndVideoContainerState extends State<FileAndVideoContainer> {

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(sections[widget.sectionIndex].videos[widget.index].fileName  ,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print("section index = ${widget.sectionIndex}");
                  print("video index = ${widget.index}");
                  print('coures = ${sections.toString()}');
                  setState(() {
                    widget.onEdit(widget.index);

                  });  },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  widget.onAdd(widget.index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.onDelete(widget.index);
                },
              ),
              IconButton(
                icon: Icon(Icons.lock_open),
                onPressed: () {
                  widget.onDuplicate(widget.index);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }


}
