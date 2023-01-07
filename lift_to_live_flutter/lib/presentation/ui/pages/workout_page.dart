import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/factory/page_factory.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/reusable_elements/custom_heading_text_field.dart';
import 'package:lift_to_live_flutter/presentation/ui/widgets/workout_related/template_set_holder.dart';
import 'package:provider/provider.dart';
import '../../presenters/workout_page_presenter.dart';
import '../../state_management/app_state.dart';
import '../../../helper.dart';
import '../../views/workout_page_view.dart';
import '../widgets/reusable_elements/custom_dialog.dart';

/// Custom WorkoutPage widget used for editing a template/workout of a user.
/// It is a stateful widget and its state object implements the WorkoutPageView abstract class.
class WorkoutPage extends StatefulWidget {
  final int templateId;
  final String userId;
  final bool forTemplate, fromTemplate;
  final WorkoutPagePresenter
      presenter; // The business logic object

  const WorkoutPage(
      {Key? key,
      required this.templateId,
      required this.presenter,
      required this.userId, required this.forTemplate, required this.fromTemplate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => WorkoutPageState();
}

/// State object of the WorkoutPage. Holds the mutable data, related to the page.
class WorkoutPageState extends State<WorkoutPage>
    implements WorkoutPageView {
  bool _isLoading =
          false, // Indicator showing if data is being fetched at the moment
      _isFetched = false;
  late double screenHeight, screenWidth;
  late List<TemplateSetHolder> _workoutWidgets;
  bool reorderEnabled = false;

  @override
  final TextEditingController nameController = TextEditingController(), noteController = TextEditingController();

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

  /// Function to set if data is fetched and should be displayed.
  @override
  void setFetched(bool inProgress) {
    setState(() {
      _isFetched = inProgress;
    });
  }

  /// Function to notify there is no name entered for the template
  @override
  void notifyNoName() {
    Helper.makeToast(context, 'Enter template name to save this template!');
  }

  /// Function to notify there is no se data entered for the template
  @override
  void notifyNoSets() {
    Helper.makeToast(context, 'Enter at least one set to save this template!');
  }

  /// Function to notify the template is saved
  @override
  void notifySaved() {
    Helper.makeToast(context,  widget.forTemplate ? 'Template has been saved successfully!' : 'Workout has been saved successfully!');
    Helper.replacePage(
        context,
        widget.forTemplate ? PageFactory()
            .getWorkoutTemplatesPage(widget.userId) : PageFactory().getWorkoutHistoryPage(widget.userId));
  }

  /// Function to notify if no workouts were found
  @override
  void notifyNoTemplatesFound() {
    Helper.makeToast(context, 'No workout entries were found!');
  }

  /// Function to set and display the workout template data.
  @override
  void setTemplateData(String templateName, String templateNote, List<TemplateSetHolder> workoutSetWidgets) {
    setState(() {
      nameController.text = templateName;
      noteController.text = templateNote;
      _workoutWidgets = workoutSetWidgets;
    });
  }

  /// Build method of the habits page view
  @override
  Widget build(BuildContext context) {
    //get screen size values
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // initialize presenter and log in form, if not initialized yet
    if (!widget.presenter.isInitialized()) {
      widget.presenter.setAppState(Provider.of<AppState>(context));
    }

    // fetch data if it is not fetched yet
    if (!_isFetched) {
      widget.presenter.fetchData();
    }

    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the user from navigating away
        return false;
      },
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 20,),
            FloatingActionButton.extended(
                heroTag: 'saveChangesButton',
                onPressed: () async {
                  await widget.presenter.saveChanges();
                },
                backgroundColor: Helper.yellowColor,
                icon: const Icon(Icons.check, color: Helper.whiteColor,),
                label: const Text('Save')),
            FloatingActionButton.extended(
                heroTag: 'addButton',
                onPressed: () {
                  widget.presenter.addNewSet();
                },
                icon: const Icon(Icons.add, color: Helper.whiteColor,),
                backgroundColor: Helper.blackColor,
                label: const Text(
                  'Add Set',
                  style: TextStyle(color: Helper.whiteColor),
                )),
            FloatingActionButton.extended(
                heroTag: 'deleteButton',
                icon: const Icon(Icons.delete_outline, color: Helper.whiteColor,),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                            title: widget.forTemplate ? 'Delete Template' : 'Delete Workout',
                            bodyText: 'Are you sure you want to delete the current workout/template?',
                            confirm: () async {
                              Navigator.pop(context);

                              if(widget.templateId != 0) {
                                widget.presenter.deleteTemplate(widget.templateId);
                              }

                              Helper.replacePage(
                                  context,
                                  widget.forTemplate ? PageFactory()
                                      .getWorkoutTemplatesPage(widget.userId) : PageFactory()
                                      .getWorkoutHistoryPage(widget.userId));
                            },
                            cancel: () {
                              Navigator.pop(context);
                            });
                      });
                },
                backgroundColor: Helper.redColor,
                label: const Text('Delete')),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.only(bottom: 70),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Helper.pageBackgroundImage),
                fit: BoxFit.fill,
              ),
            ),
            child: (!_isLoading && _isFetched)
                ? CustomScrollView(slivers: <Widget>[
                    SliverAppBar(
                      actions: [
                        IconButton(
                            icon: Icon(Icons.reorder,
                                color: !reorderEnabled ? Helper.yellowColor : Helper.yellowColor.withOpacity(0.33)),
                            onPressed: () {
                              setState(() {
                                reorderEnabled = !reorderEnabled;
                              });
                            })
                      ],
                      leading: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Helper.yellowColor),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                      title: 'Cancel Edit',
                                      bodyText: 'Are you sure you want to cancel your edit and discard the changes made?',
                                      confirm: () {
                                        Navigator.pop(context);
                                        Helper.replacePage(
                                            context,
                                            widget.forTemplate ? PageFactory()
                                                .getWorkoutTemplatesPage(widget.userId) : PageFactory().getWorkoutHistoryPage(widget.userId));
                                      },
                                      cancel: () {
                                        Navigator.pop(context);
                                      });
                                });
                          }),
                      iconTheme: const IconThemeData(
                        color: Helper.yellowColor, //change your color here
                      ),
                      backgroundColor: Helper.lightBlueColor,
                      pinned: true,
                      snap: true,
                      floating: true,
                      expandedHeight: 100.0,
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          widget.forTemplate ? widget.templateId!=0 ? 'Edit Template' : 'New Template' : widget.templateId!=0 ? 'Edit Workout' : 'New Workout' ,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w300),
                        ),
                        centerTitle: true,
                      ),
                    ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return !reorderEnabled ? Column(
                      children: [
                        const SizedBox(height: 10,),
                        CustomHeadingTextField(screenHeight: screenHeight, screenWidth: screenWidth, controller: nameController, textInputType: TextInputType.text, hint: 'Enter workout name', icon: Icons.drive_file_rename_outline, color: Helper.yellowColor, isHeadline: true,),
                        const SizedBox(height: 10,),
                        CustomHeadingTextField(screenHeight: screenHeight, screenWidth: screenWidth, controller: noteController, textInputType: TextInputType.multiline, hint: 'Enter workout note', icon: Icons.notes, color: Helper.whiteColor, isHeadline: false,),
                        const SizedBox(height: 20,),
                      ],
                    ) : const SizedBox();
                  },
                  childCount: 1,
                ),
              ),
                    SliverReorderableList(
                      itemBuilder: (BuildContext context, int index) {
                        return ReorderableDragStartListener(
                          enabled: reorderEnabled,
                          key: Key(index.toString()),
                          index: index,
                          child: Container(
                            color: index.isOdd
                                ? Helper.blueColor.withOpacity(0.12)
                                : Helper.blueColor.withOpacity(0.12),
                            padding: const EdgeInsets.all(10),
                            child: reorderEnabled ? Column(
                              children: [
                                Text('Set #${index+1}', style: const TextStyle(color: Helper.yellowColor, fontSize: 22),),
                              ],
                            ) : Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Set #${index+1}', style: const TextStyle(color: Helper.yellowColor, fontSize: 22),),
                                  IconButton(onPressed: (){
                                    setState(() {
                                      _workoutWidgets.removeAt(index);
                                    });
                                  }, icon: const Icon(Icons.delete_outline, color: Helper.yellowColor, size: 30,))
                                ],
                              ),
                              _workoutWidgets[index]
                            ],),
                          ),
                        );
                      },
                      itemCount: _workoutWidgets.length,
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }
                          final item = _workoutWidgets[oldIndex];
                          _workoutWidgets.removeAt(oldIndex);
                          _workoutWidgets.insert(newIndex, item);
                          reorderEnabled = false;
                        });
                      },
                    ),
                  ])
                : const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Helper.yellowColor,
                      ),
                    ),
                  )),
      ),
    );
  }
}
