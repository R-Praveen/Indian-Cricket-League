import 'package:indian_cricket_league/helpers/constants.dart';

String getShortFormNames(String name) {
  String shortForm = '';
  switch (name) {
    case TeamNames.chennai:
      shortForm = 'CSK';
      break;
    case TeamNames.mumbai:
      shortForm = 'MI';
      break;
    case TeamNames.bangalore:
      shortForm = 'RCB';
      break;
    case TeamNames.hyderabad:
      shortForm = 'SRH';
      break;
    case TeamNames.hyderabad:
      shortForm = 'DCH';
      break;
    case TeamNames.punjab:
      shortForm = 'KXIP';
      break;
    case TeamNames.rajasthan:
      shortForm = 'RR';
      break;
    case TeamNames.kolkata:
      shortForm = 'KKR';
      break;
    case TeamNames.pune:
      shortForm = 'RPS';
      break;
    case TeamNames.gujarat:
      shortForm = 'GL';
      break;
    case TeamNames.delhi:
      shortForm = 'DD';
      break;
    case TeamNames.delhiCapitals:
      shortForm = 'DC';
      break;
  }
  return shortForm;
}

String getAssetString(String winner) {
  String assetString = '';
  switch (winner) {
    case TeamNames.chennai:
      assetString = 'assets/csk.jpeg';
      break;
    case TeamNames.mumbai:
      assetString = 'assets/mi.jpeg';
      break;
    case TeamNames.bangalore:
      assetString = 'assets/rcb.jpeg';
      break;
    case TeamNames.hyderabad:
      assetString = 'assets/srh.jpeg';
      break;
    case TeamNames.hyderabadDeccanChargers:
      assetString = 'assets/srh.jpeg';
      break;
    case TeamNames.kolkata:
      assetString = 'assets/kkr.png';
      break;
    case TeamNames.rajasthan:
      assetString = 'assets/rr.png';
      break;
    case TeamNames.delhi:
      assetString = 'assets/dc.jpeg';
      break;
    case TeamNames.delhiCapitals:
      assetString = 'assets/dc.jpeg';
      break;
    case TeamNames.punjab:
      assetString = 'assets/pk.png';
      break;
    case TeamNames.pune:
      assetString = 'assets/rps.jpeg';
      break;
    case TeamNames.gujarat:
      assetString = 'assets/gl1.png';
      break;
  }
  return assetString;
}
