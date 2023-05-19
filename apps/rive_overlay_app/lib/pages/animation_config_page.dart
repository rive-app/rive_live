// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rive_overlay_app/models/animations_data.dart';
import 'package:rive_overlay_app/utils.dart';

import '../theme.dart';

class AnimationConfigPage extends StatelessWidget {
  const AnimationConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Animation Config Page'),
      ),
      body: const Center(child: ExampleDragTarget()),
    );
  }
}

class ExampleDragTarget extends StatefulWidget {
  const ExampleDragTarget({Key? key}) : super(key: key);

  @override
  State<ExampleDragTarget> createState() => _ExampleDragTargetState();
}

class _ExampleDragTargetState extends State<ExampleDragTarget> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  AnimationData? animationData;
  StateMachineController? controller;

  late StreamSubscription<AnimationData?> subscription;

  Future<void> loadData() async {
    final isar = context.read<Isar>();

    final dataChanged =
        isar.animationDatas.watchObject(1, fireImmediately: true);

    subscription = dataChanged.listen((event) async {
      animationData = event;
      if (event != null) {
        riveFile = await RiveFile.file(event.path!);
      } else {
        riveFile = null;
      }
      setState(() {});
    });
  }

  XFile? riveFilePath;
  RiveFile? riveFile;

  bool _dragging = false;

  Future<void> _onDragDone(DropDoneDetails detail) async {
    riveFilePath = detail.files.first;
    final isar = context.read<Isar>();

    riveFile = await RiveFile.file(riveFilePath!.path);

    animationData = animationData ?? (AnimationData())
      ..path = riveFilePath!.path
      ..artboard = riveFile!.mainArtboard.name
      ..stateMachine = riveFile!.mainArtboard.defaultStateMachine?.name ??
          riveFile!.mainArtboard.stateMachines.first.name;

    await isar.writeTxn(() async {
      await isar.animationDatas.put(animationData!);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropTarget(
          onDragDone: _onDragDone,
          onDragEntered: (detail) {
            setState(() {
              _dragging = true;
            });
          },
          onDragExited: (detail) {
            setState(() {
              _dragging = false;
            });
          },
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Aspect Ratio: 16:9',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: RiveColors().grey88),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _dragging ? RiveColors().blue : Colors.transparent,
                      border: Border.all(color: RiveColors().grey88),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: riveFile == null
                          ? const Center(
                              child: Text("Drag and drop animation here"))
                          : RiveAnimation.direct(
                              riveFile!,
                              artboard: animationData?.artboard,
                              onInit: (artboard) {
                                if (animationData?.stateMachine != null) {
                                  controller =
                                      StateMachineController.fromArtboard(
                                          artboard,
                                          animationData!.stateMachine!);
                                  artboard.addController(controller!);
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: (riveFile == null)
              ? const SizedBox(
                  width: 300,
                  child: Center(child: Text("No animation set")),
                )
              : SizedBox(
                  width: 300,
                  child: AnimationDetails(
                    riveFile: riveFile!,
                    animationData: animationData!,
                    onSample: () {
                      if (animationData?.trigger != null) {
                        final trigger =
                            controller?.findInput<bool>(animationData!.trigger!)
                                as SMITrigger?;
                        trigger?.fire();
                      }
                    },
                  ),
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

class AnimationDetails extends StatefulWidget {
  const AnimationDetails({
    Key? key,
    required this.riveFile,
    required this.animationData,
    required this.onSample,
  }) : super(key: key);

  final RiveFile riveFile;
  final AnimationData animationData;
  final VoidCallback onSample;

  @override
  State<AnimationDetails> createState() => _AnimationDetailsState();
}

class _AnimationDetailsState extends State<AnimationDetails> {
  late String? _animationPath;

  late List<Artboard> artboards;
  late Artboard selectedArtboard;

  Iterable<StateMachine> stateMachines = [];
  StateMachine? selectedStateMachine;

  Iterable<SMITrigger> triggers = [];
  SMITrigger? selectedTrigger;

  @override
  void initState() {
    super.initState();
    _initDefaults();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    if (_animationPath != widget.animationData.path) {
      _initDefaults();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initDefaults() {
    _animationPath = widget.animationData.path;

    _refreshAvailableArtboards();

    _refreshAvailableStateMachines();

    _refreshAvailableTriggers();

    _save();
  }

  /// Refreshes the available artboards
  void _refreshAvailableArtboards() {
    artboards = widget.riveFile.artboards;
    selectedArtboard =
        widget.riveFile.artboardByName(widget.animationData.artboard!)!;
  }

  /// Refreshes the available state machines
  void _refreshAvailableStateMachines() {
    stateMachines = selectedArtboard.stateMachines;
    selectedStateMachine = selectedArtboard.defaultStateMachine ??
        selectedArtboard.stateMachines.first;
  }

  /// Refreshes the available triggers
  void _refreshAvailableTriggers() {
    triggers = StateMachineController(selectedStateMachine!)
        .inputs
        .whereType<SMITrigger>();

    if (triggers.isEmpty) {
      selectedTrigger = null;
      return;
    }
    selectedTrigger = triggers.first;
  }

  /// Set selected artboard, refresh defaults, and save.
  void _setSelectedArtboard(Artboard? artboard) {
    setState(() {
      // Set selected artboard
      selectedArtboard = artboard!;

      // Refresh defaults
      _refreshAvailableStateMachines();
      _refreshAvailableTriggers();
    });

    _save();
  }

  /// Set selected state machine, refresh defaults and save.
  void _setSelectedStateMachine(StateMachine? stateMachine) {
    setState(() {
      selectedStateMachine = stateMachine!;

      // Refresh defaults
      _refreshAvailableTriggers();
    });
    _save();
  }

  /// Set selected trigger, and save.
  void _setSelectedTrigger(SMITrigger? value) {
    setState(() {
      // Set selected trigger
      selectedTrigger = value!;
    });
    _save();
  }

  /// Clears the database
  void _clearLocalStorage() {
    final isar = context.read<Isar>();
    isar.writeTxn(() async {
      await isar.animationDatas.clear();
    });
  }

  /// Saves the animation data to local storage
  void _save() {
    final isar = context.read<Isar>();
    isar.writeTxn(() async {
      final animationData = await isar.animationDatas.get(1);
      animationData!.artboard = selectedArtboard.name;
      animationData.stateMachine = selectedStateMachine?.name;
      animationData.trigger = selectedTrigger?.name;
      await isar.animationDatas.put(animationData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child:
                Text('Artboard', style: Theme.of(context).textTheme.bodySmall),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Artboard>(
              hint: const Text('Artboard'),
              value: selectedArtboard,
              isDense: true,
              onChanged: _setSelectedArtboard,
              items: artboards
                  .map<DropdownMenuItem<Artboard>>(
                      (Artboard value) => DropdownMenuItem<Artboard>(
                            value: value,
                            child: Text(value.name),
                          ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child: Text('State Machine',
                style: Theme.of(context).textTheme.bodySmall),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<StateMachine>(
              hint: const Text('State Machine'),
              value: selectedStateMachine,
              isDense: true,
              onChanged: _setSelectedStateMachine,
              items: stateMachines
                  .map<DropdownMenuItem<StateMachine>>(
                      (StateMachine value) => DropdownMenuItem<StateMachine>(
                            value: value,
                            child: Text(value.name),
                          ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8),
            child:
                Text('Trigger', style: Theme.of(context).textTheme.bodySmall),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<SMITrigger>(
              hint: const Text('Triggers'),
              value: selectedTrigger,
              isDense: true,
              onChanged: _setSelectedTrigger,
              items: triggers
                  .map<DropdownMenuItem<SMITrigger>>(
                      (SMITrigger value) => DropdownMenuItem<SMITrigger>(
                            value: value,
                            child: Text(value.name),
                          ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: 'Preview the animation',
              child: ElevatedButton(
                onPressed: () {
                  if (selectedTrigger == null) {
                    Utils.showMessage(context,
                        '⚠️ WARNING: this animation does not have a trigger configured');
                  }
                  widget.onSample.call();
                },
                child: const Text('Demo'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: RiveColors().grey88,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: 'Clear the animation',
              child: ElevatedButton(
                  onPressed: _clearLocalStorage, child: const Text('Restart')),
            ),
          ),
        ],
      ),
    );
  }
}
