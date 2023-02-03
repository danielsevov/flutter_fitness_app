import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presenters/picture_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/picture_page_view.dart';

/// Custom PicturePage widget used as a main overview of the pictures of a user.
/// It provides overview of the user's pictures.
/// It is a stateful widget and its state object implements the PicturePageView abstract class.
class PicturePage extends StatefulWidget {
  final String userId;
  final String name;
  final PicturePagePresenter
      presenter; // The business logic object of the log in page

  const PicturePage(
      {Key? key,
      required this.userId,
      required this.name,
      required this.presenter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PicturePageState();
}

/// State object of the PicturePage. Holds the mutable data, related to the page.
class PicturePageState extends State<PicturePage> implements PicturePageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late List<Widget> _picturesSide, _picturesFront, _picturesBack;

  /// initialize the page view by attaching it to the presenter
  @override
  void initState() {
    widget.presenter.attach(this);
    super.initState();
  }

  /// detach the view from the presenter
  @override
  void deactivate() {
    widget.presenter.detach();
    super.deactivate();
  }

  /// Function to set if data is currently being fetched and an loading indicator should be displayed.
  @override
  void setInProgress(bool inProgress) {
    setState(() {
      _isLoading = inProgress;
    });
  }

  /// Function to set and display the user pictures.
  @override
  void setPictures(List<Widget> pictureSide, List<Widget> pictureFront,
      List<Widget> pictureBack) {
    setState(() {
      _picturesSide = pictureSide;
      _picturesFront = pictureFront;
      _picturesBack = pictureBack;
      _isFetched = true;
    });
  }

  /// Build method of the picture page view
  @override
  Widget build(BuildContext context) {
    // initialize presenter and log in form, if not initialized yet
    if (!widget.presenter.isInitialized()) {
      widget.presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      widget.presenter.fetchData();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.name}'s Photo Album",
          style: const TextStyle(color: Helper.lightHeadlineColor),
        ),
        backgroundColor: Helper.lightBlueColor.withOpacity(0.9),
        elevation: 20,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Helper.darkHeadlineColor, //change your color here
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Helper.yellowColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage(Helper.pageBackgroundImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_upward, color: Helper.yellowColor,),
                          const Text(
                            " Front Photos",
                            style: TextStyle(
                                color: Helper.yellowColor, fontSize: 24),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          widget.presenter.isAuthorized()
                              ? CircleAvatar(
                                  backgroundColor: Helper.actionButtonColor,
                                  child: IconButton(
                                      onPressed: () {
                                        widget.presenter.addPicture("front");
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Helper.actionButtonTextColor)),
                                )
                              : const SizedBox()
                        ],
                      ),
                      const Divider(
                        color: Helper.whiteColor,
                        thickness: 1,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                        height: _picturesFront.isNotEmpty ? 300 : 100,
                        child: _picturesFront.isNotEmpty ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: _picturesFront,
                        ) : const Text('No front pictures found.', style: TextStyle(color: Helper.whiteColor),),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.arrow_down, color: Helper.yellowColor,),
                          const Text(
                            " Back Photos",
                            style: TextStyle(
                                color: Helper.yellowColor, fontSize: 24),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          widget.presenter.isAuthorized()
                              ? CircleAvatar(
                                  backgroundColor: Helper.actionButtonColor,
                                  child: IconButton(
                                      onPressed: () {
                                        widget.presenter.addPicture("back");
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Helper.actionButtonTextColor)),
                                )
                              : const SizedBox()
                        ],
                      ),
                      const Divider(
                        color: Helper.whiteColor,
                        thickness: 1,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                        height: _picturesBack.isNotEmpty ? 300 : 100,
                        child: _picturesBack.isNotEmpty ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: _picturesBack,
                        ) : const Text('No back pictures found.', style: TextStyle(color: Helper.whiteColor),),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.subdirectory_arrow_left , color: Helper.yellowColor,),
                          const Text(
                            " Side Photos",
                            style: TextStyle(
                                color: Helper.yellowColor, fontSize: 24),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          widget.presenter.isAuthorized()
                              ? CircleAvatar(
                                  backgroundColor: Helper.actionButtonColor,
                                  child: IconButton(
                                      onPressed: () {
                                        widget.presenter.addPicture("side");
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Helper.actionButtonTextColor)),
                                )
                              : const SizedBox()
                        ],
                      ),
                      const Divider(
                        color: Helper.whiteColor,
                        thickness: 1,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                        height: _picturesSide.isNotEmpty ? 300 : 100,
                        child: _picturesSide.isNotEmpty ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: _picturesSide,
                        ) : const Text('No side pictures found.', style: TextStyle(color: Helper.whiteColor),),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ),
    );
  }

  /// Function to add a new image entry.
  @override
  void addNewPicture(Image img, String type) {
    setState(() {
      if (type == 'side') {
        _picturesSide.add(img);
      }
      if (type == 'back') {
        _picturesBack.add(img);
      }
      if (type == 'front') {
        _picturesFront.add(img);
      }
      _isFetched = true;
    });
  }
}
