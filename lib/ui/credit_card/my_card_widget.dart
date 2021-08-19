import 'package:flutter/material.dart';

class MyCardWidget extends StatefulWidget {
  final String? cardNumber;
  final String? expiryDate;
  final String? cardHolderName;
  final String? cvvCode;
  final bool flag;
  final CardType? cardType;

  MyCardWidget({
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.cardType,
    this.flag = false,
  });

  @override
  _MyCardWidgetState createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends State<MyCardWidget> {

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const <double>[0.1, 0.4, 0.7, 0.9],
          colors: <Color>[
            Color(0xff1b447b).withOpacity(1),
            Color(0xff1b447b).withOpacity(0.97),
            Color(0xff1b447b).withOpacity(0.90),
            Color(0xff1b447b).withOpacity(0.86),
          ],
        ),
      ),
      margin: const EdgeInsets.all(16),
      width: width,
      height: (orientation == Orientation.portrait ? height / 4 : height / 2),
      child: widget.flag == false ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: widget.cardType == null ? Container() : widget.cardType == CardType.visa ?
              Image.asset('assets/image/visa.png',width: 50,height: 50,):
              Image.asset('assets/image/mastercard.png',width: 50,height: 50,)
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: widget.cardNumber == null
                  ? Text(
                      'XXXX XXXX XXXX XXXX',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ha',
                        fontSize: 16,
                      ),
                    )
                  : Text(
                      widget.cardNumber!,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ha',
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: widget.expiryDate == null
                  ? Text(
                      'MM/YY',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ha',
                        fontSize: 16,
                      ),
                    )
                  : Text(
                      widget.expiryDate!,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ha',
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: widget.cardHolderName == null
                  ? Text(
                      'CARD HOLDER',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ha',
                        fontSize: 16,
                      ),
                    )
                  : Text(
                      widget.cardHolderName!,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'ha',
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ):Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                height: 48,
                color: Colors.black,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Container(
                        height: 48,
                        color: Colors.white70,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            widget.cvvCode == null
                                ? 'XXX'
                                : widget.cvvCode!,
                            maxLines: 1,
                            style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'ha',
                            fontSize: 16,
                          ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: widget.cardType == null ? Container() : widget.cardType == CardType.visa ?
                    Image.asset('assets/image/visa.png',width: 50,height: 50,):
                    Image.asset('assets/image/mastercard.png',width: 50,height: 50,)
                ),
              ),
            ),
          ],
        )
    );
  }
}

enum CardType {
  mastercard,
  visa,
}
