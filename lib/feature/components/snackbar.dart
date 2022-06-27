import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SnackBar snackbarWanrning(String warningText) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Center(
            child: Text(
              warningText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: -15,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 9, 9),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              const Positioned.fill(
                child: Icon(
                  CupertinoIcons.exclamationmark,
                  color: Colors.white,
                  size: 15,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

//
//

SnackBar snackbarSuccess(String warningText) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 70,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 27, 27, 27).withOpacity(0.6),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Center(
            child: Text(
              warningText,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: -10,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 255, 34),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              const Positioned(
                top: 5,
                child: Icon(
                  CupertinoIcons.check_mark,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
