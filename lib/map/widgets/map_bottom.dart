import 'package:flutter/material.dart';

class MapBottom extends StatelessWidget {
  const MapBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(12, 80, 78, 78).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 5, 25, 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 28.0,
                        ),
                      ),
                      const Text(
                        "Sachin seram",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20.0),
                      child: FloatingActionButton(
                        backgroundColor: Color.fromARGB(255, 112, 138, 243),
                        onPressed: () {},
                        child: const Icon(
                          Icons.directions_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
