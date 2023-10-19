// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
class PaginationWidget extends StatefulWidget {
  int? offSet;
  ScrollController? scrollController;
  Future<void> Function(int)? onPagination;
  int? totalSize;
  Widget? items;
  bool isPagination;
  PaginationWidget(
      {this.offSet,
      this.scrollController,
      this.onPagination,
      this.totalSize,
      this.items,
      this.isPagination = true});

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int _offset = 0;
  List<int>? _offsetList;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    print("++++++++${_offset}");
    _offset = 1;
    _offsetList = [1];

    widget.scrollController?.addListener(() {
      if (widget.scrollController?.position.pixels ==
              widget.scrollController?.position.maxScrollExtent &&
          widget.totalSize != null &&
          !_isLoading &&
          widget.isPagination) {
        pagination();
      }
    });
  }

  void pagination() async {
    int pageSize = ((widget.totalSize ?? 0) / 10).ceil();
    print(pageSize);
    if ((_offset) < pageSize && !_offsetList!.contains(_offset + 1)) {
      setState(() {
        _offset++;
        _offsetList?.add((_offset));
        _isLoading = true;
      });
      print("**************${_offset}");
      await widget.onPagination!(_offset);
      setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offSet != null) {
      print('offset ${widget.offSet}');
      _offset = widget.offSet!;
      _offsetList = [];
      for (int i = 1; i <= (widget.offSet ?? 0); i++) {
        _offsetList?.add(i);
      }
      print("dsfhfgh-$_offsetList");
    }
    return Column(children: [
      widget.items ?? SizedBox(),
      ((widget.totalSize == null ||
              (_offset) >= ((widget.totalSize ?? 0) / 10).ceil() ||
              _offsetList!.contains((_offset) + 1)))
          ? SizedBox()
          : Center(
              child: Padding(
              padding: (_isLoading) ? EdgeInsets.all(5) : EdgeInsets.zero,
              child: _isLoading ? CircularProgressIndicator() : SizedBox(),
            )),
    ]);
  }
}
