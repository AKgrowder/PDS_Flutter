// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

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
              widget.scrollController?.position.minScrollExtent &&
              // maxScrollExtent &&
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
      super.setState(() {
        _offset++;
        _offsetList?.add((_offset));
        _isLoading = true;
      });
      print("**************${_offset}");
      await widget.onPagination!(_offset);
      super.setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        super.setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offSet != null) {
      // print('offset ${widget.offSet}');
      _offset = widget.offSet!;
      _offsetList = [];
      for (int i = 1; i <= (widget.offSet ?? 0); i++) {
        _offsetList?.add(i);
      }
      // print("dsfhfgh-$_offsetList");
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
              child: _isLoading
                  ? GFLoader(
                      type: GFLoaderType.ios,
                    )
                  : SizedBox(),
            )),
    ]);
  }
}


class PaginationWidget1 extends StatefulWidget {
  int? offSet;
  ScrollController? scrollController;
  Future<void> Function(int)? onPagination;
  int? totalSize;
  Widget? items;
  bool isPagination;
  PaginationWidget1(
      {this.offSet,
      this.scrollController,
      this.onPagination,
      this.totalSize,
      this.items,
      this.isPagination = true});

  @override
  State<PaginationWidget1> createState() => _PaginationWidget1State();
}

class _PaginationWidget1State extends State<PaginationWidget1> {
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
      super.setState(() {
        _offset++;
        _offsetList?.add((_offset));
        _isLoading = true;
      });
      print("**************${_offset}");
      await widget.onPagination!(_offset);
      super.setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        super.setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offSet != null) {
      // print('offset ${widget.offSet}');
      _offset = widget.offSet!;
      _offsetList = [];
      for (int i = 1; i <= (widget.offSet ?? 0); i++) {
        _offsetList?.add(i);
      }
      // print("dsfhfgh-$_offsetList");
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
              child: _isLoading
                  ? GFLoader(
                      type: GFLoaderType.ios,
                    )
                  : SizedBox(),
            )),
    ]);
  }
}
class PaginationWidgetMinScroll extends StatefulWidget {
  int? offSet;
  ScrollController? scrollController;
  Future<void> Function(int)? onPagination;
  int? totalSize;
  Widget? items;
  bool isPagination;
  PaginationWidgetMinScroll(
      {this.offSet,
      this.scrollController,
      this.onPagination,
      this.totalSize,
      this.items,
      this.isPagination = true});

  @override
  State<PaginationWidgetMinScroll> createState() =>
      _PaginationWidgetMinScrollState();
}

class _PaginationWidgetMinScrollState extends State<PaginationWidgetMinScroll> {
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
              widget.scrollController?.position.minScrollExtent &&
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
      super.setState(() {
        _offset++;
        _offsetList?.add((_offset));
        _isLoading = true;
      });
      print("**************${_offset}");
      await widget.onPagination!(_offset);
      super.setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        super.setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offSet != null) {
      // print('offset ${widget.offSet}');
      _offset = widget.offSet!;
      _offsetList = [];
      for (int i = 1; i <= (widget.offSet ?? 0); i++) {
        _offsetList?.add(i);
      }
      // print("dsfhfgh-$_offsetList");
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
              child: _isLoading
                  ? GFLoader(
                      type: GFLoaderType.ios,
                    )
                  : SizedBox(),
            )),
    ]);
  }
}



//////  only for chat Listing  
///
class chatPaginationWidget extends StatefulWidget {
  int? offSet;
  ScrollController? scrollController;
  Future<void> Function(int)? onPagination;
  int? totalSize;
  Widget? items;
  bool isPagination;
  chatPaginationWidget(
      {this.offSet,
      this.scrollController,
      this.onPagination,
      this.totalSize,
      this.items,
      this.isPagination = true});

  @override
  State<chatPaginationWidget> createState() => _chatPaginationWidgetState();
}

class _chatPaginationWidgetState extends State<chatPaginationWidget> {
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
              widget.scrollController?.position.minScrollExtent &&
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
      super.setState(() {
        _offset++;
        _offsetList?.add((_offset));
        _isLoading = true;
      });
      print("**************${_offset}");
      await widget.onPagination!(_offset);
      super.setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        super.setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offSet != null) {
      // print('offset ${widget.offSet}');
      _offset = widget.offSet!;
      _offsetList = [];
      for (int i = 1; i <= (widget.offSet ?? 0); i++) {
        _offsetList?.add(i);
      }
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
              child: _isLoading
                  ? GFLoader(
                      type: GFLoaderType.ios,
                    )
                  : SizedBox(),
            )),
    ]);
  }
}

class chatPaginationWidgetMinScroll extends StatefulWidget {
  int? offSet;
  ScrollController? scrollController;
  Future<void> Function(int)? onPagination;
  int? totalSize;
  Widget? items;
  bool isPagination;
  chatPaginationWidgetMinScroll(
      {this.offSet,
      this.scrollController,
      this.onPagination,
      this.totalSize,
      this.items,
      this.isPagination = true});

  @override
  State<PaginationWidgetMinScroll> createState() =>
      _PaginationWidgetMinScrollState();
}

class _chatPaginationWidgetMinScrollState extends State<PaginationWidgetMinScroll> {
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
              widget.scrollController?.position.minScrollExtent &&
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
      super.setState(() {
        _offset++;
        _offsetList?.add((_offset));
        _isLoading = true;
      });
      print("**************${_offset}");
      await widget.onPagination!(_offset);
      super.setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        super.setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offSet != null) {
      // print('offset ${widget.offSet}');
      _offset = widget.offSet!;
      _offsetList = [];
      for (int i = 1; i <= (widget.offSet ?? 0); i++) {
        _offsetList?.add(i);
      }
      // print("dsfhfgh-$_offsetList");
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
              child: _isLoading
                  ? GFLoader(
                      type: GFLoaderType.ios,
                    )
                  : SizedBox(),
            )),
    ]);
  }
}
