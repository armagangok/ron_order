
import 'package:flutter/material.dart';

SnackBar getSnackBar(String warningText) {
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
            color: Colors.grey.withOpacity(0.6),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bi hata yakalandı!',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      warningText,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 25,
          left: 20,
          child: ClipRRect(
            child: Stack(
              children: const [
                Icon(
                  Icons.circle,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 17,
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 5,
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
              const Positioned(
                top: 5,
                child: Icon(
                  Icons.clear_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

SnackBar getSnackBar1(String warningText) {
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
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15)),
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
        // Positioned(
        //   bottom: 25,
        //   left: 20,
        //   child: ClipRRect(
        //     child: Stack(
        //       children: const [
        //         Icon(
        //           Icons.circle,
        //           color: Color.fromARGB(255, 255, 255, 255),
        //           size: 17,
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Positioned(
          top: -20,
          left: 5,
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
              const Positioned(
                  top: 5,
                  child: Icon(
                    Icons.clear_outlined,
                    color: Colors.white,
                    size: 20,
                  ))
            ],
          ),
        ),
      ],
    ),
  );
}
