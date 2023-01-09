import 'package:flutter/material.dart';
import '../../../../helper.dart';

/// A holder for a single set task, part of a workout/template set entry.
class SetTaskHolder extends StatefulWidget {
  final TextEditingController repsController, kilosController, isCompletedController;
  final bool isEnabled, isTemplate;

  const SetTaskHolder(
      {Key? key, required this.repsController, required this.kilosController, required this.isCompletedController, required this.isEnabled, required this.isTemplate})
      : super(key: key);

  @override
  State<SetTaskHolder> createState() => _SetTaskHolderState();
}

class _SetTaskHolderState extends State<SetTaskHolder> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Helper.lightBlueColor,
          borderRadius: BorderRadius.circular(10),
          //border: Border.all(color: Helper.whiteColor, width: 0.75),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // text field for entering kilogram values
              Row(
                children: [
                  SizedBox(
                    width: 70,
                    height: widget.isEnabled ? 50 : 20,
                    child: TextField(
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: widget.isEnabled ? Helper.blueColor.withOpacity(0.7) : Helper.lightBlueColor,
                        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                      ),
                      enabled: widget.isEnabled,
                      onSubmitted: (newString){
                        try {
                          int.parse(newString);
                        }
                        catch (e) {
                          setState(() {
                            widget.kilosController.text = '';
                          });
                        }
                      },
                      controller: widget.kilosController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Helper.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),

              // text field for entering repetition values
              Row(
                children: [
                  SizedBox(
                    width: 70,
                  height: widget.isEnabled ? 50 : 20,
                    child: TextField(
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: widget.isEnabled ? Helper.blueColor.withOpacity(0.7) : Helper.lightBlueColor,
                          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)))
                      ),
                      enabled: widget.isEnabled,
                      onSubmitted: (newString){
                        try {
                          int.parse(newString);
                        }
                        catch (e) {
                          setState(() {
                            widget.repsController.text = '';
                          });
                        }
                      },
                      controller: widget.repsController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Helper.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),

              // check box for entering isCompleted values
              !widget.isTemplate ? SizedBox(
                width: 50, height: widget.isEnabled ? 50 : 20,
                child: Checkbox(
                          side:
                              const BorderSide(color: Helper.yellowColor, width: 2),
                          checkColor: Helper.blackColor,
                          fillColor: MaterialStateProperty.all(
                              !widget.isEnabled
                                  ? Helper.yellowColor.withOpacity(0.3)
                                  : Helper.yellowColor.withOpacity(1)),
                          value: widget.isCompletedController.text == 'true',
                          onChanged: (isComplete) {
                            if(widget.isEnabled) {
                              setState(() {
                                widget.isCompletedController.text = isComplete.toString();
                              });
                            }
                          },
                        ),
              ) : const SizedBox()
            ],
          ),
        ));
  }
}
