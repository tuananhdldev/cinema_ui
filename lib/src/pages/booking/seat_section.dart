import 'package:flutter/material.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/data/model.dart';

class MovieCinema extends StatelessWidget {
  const MovieCinema({Key? key, required this.cinema}) : super(key: key);
  final Location cinema;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: cinema.sections
          .map((seatSection) => MovieSeatSection(seats: seatSection.seats))
          .toList(),
    );
  }
}

class MovieSeatSection extends StatelessWidget {
  const MovieSeatSection({Key? key, required this.seats}) : super(key: key);
  final List<Seat> seats;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            padding: const EdgeInsets.all(10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: seats.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (_, index) {
              final seat = seats[index];
              return MovieSeatCard(seat: seat);
            }),
      ),
    );
  }
}

class MovieSeatCard extends StatefulWidget {
  const MovieSeatCard({Key? key, required this.seat}) : super(key: key);

  final Seat seat;
  @override
  State<MovieSeatCard> createState() => _MovieSeatCardState();
}

class _MovieSeatCardState extends State<MovieSeatCard> {
  @override
  Widget build(BuildContext context) {
    final color = widget.seat.isHidden
        ? AppColors.primaryBackgroundlColor
        : widget.seat.isBusy
            ? Colors.white
            : widget.seat.isSelected
                ? AppColors.primaryColor
                : AppColors.secondaryColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.seat.isSelected = !widget.seat.isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
