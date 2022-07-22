import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delay; //Temps entre les elements

  const DelayedAnimation({Key? key, required this.child, required this.delay})
      : super(key: key);

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animeOffset;

  //Initialisons les valeurs

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 250), //Duree que prend l'aimation avant de commencer
    );

    final curve = CurvedAnimation(
        parent: _controller,
        curve: Curves.decelerate); //C'est le type d'animation defini

    _animeOffset = Tween(
      begin: const Offset(0.0, 0.35), //defini la position de debut
      end: Offset.zero, //definit la position de fin
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward(); //Pour commencer le controller
    });
  }

  @override
  Widget build(BuildContext context) {
    //on va pouvoir inserer des widgets d'animation et mettres les parametres iinitialiser en haut dans leur parametres a eux
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animeOffset,
        child: widget.child,
      ), //Pour faire slider de haut en bas ou de gauches a droite
    ); //Pour une especes de fondu
  }
}
