import 'package:flutter/material.dart';
import 'package:mineswiper/models/puzzle_state.dart';
import 'package:mineswiper/puzzle/layout/responsive_gap.dart';
import 'package:mineswiper/widgets/puzzle_name.dart';

class MineStartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const MineStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        const PuzzleName(),
        const ResponsiveGap(large: 16),
        // MinePuzzleTitle(
        //   status: state.puzzleStatus,
        // ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        // NumberOfMovesAndTilesLeft(
        //   numberOfMoves: state.numberOfMoves,
        //   numberOfTilesLeft: state.numberOfTilesLeft,
        // ),
        const ResponsiveGap(large: 32),
        // ResponsiveLayoutBuilder(
        //   small: (_, __) => const SizedBox(),
        //   medium: (_, __) => const SizedBox(),
        //   large: (_, __) => const MinePuzzleShuffleButton(),
        // ),
      ],
    );
  }
}
