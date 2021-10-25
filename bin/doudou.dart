import 'dart:math';

import 'package:doudou/doudou.dart' as doudou;

int nombreExecution = 1000000;
void main(List<String> arguments) {
  Status getNextStatus(Status currentStatus) {
    var random = Random();

    switch (currentStatus) {
      case Status.dormir:
        if (random.nextInt(10) == 1) {
          //une chance sur dix
          return Status.reveil;
        } else {
          return Status.dormir;
        }

      case Status.reveil:
        if (random.nextInt(2) == 1) {
          //une chance sur deux d'aller manger
          return Status.manger;
        } else {
          //une chance sur deux d'aller faire de l'exercice
          return Status.exercice;
        }
      case Status.manger:
        if (random.nextInt(10) < 3) {
          //3 chance sur dix d'aller faire de l'exercice
          return Status.exercice;
        } else {
          //7 chance sur dix d'aller dormir
          return Status.dormir;
        }
      case Status.exercice:
        if (random.nextInt(10) < 2) {
          return Status.exercice;
          //2 chances sur dix de continuer l'exercice
        } else {
          //8 chances sur dix d'aller dormir
          return Status.dormir;
        }
    }
  }

  Resultat run(Status baseStatus) {
    var currentStatus = baseStatus;
    var numberOfDormir = 0;
    var numberOfMangeoire = 0;
    var numberOfRoue = 0;

    for (var i = 0; i < nombreExecution; i++) {
      switch (currentStatus) {
        case Status.dormir:
          numberOfDormir++;
          break;
        case Status.exercice:
          numberOfRoue++;
          break;
        case Status.manger:
          numberOfMangeoire++;
          break;
        default:
      }
      currentStatus = getNextStatus(currentStatus);
    }
    return Resultat(
        numberOfDormir: numberOfDormir,
        numberOfMangeoire: numberOfMangeoire,
        numberOfRoue: numberOfRoue);
  }

  void start() {
    var endResult =
        Resultat(numberOfDormir: 0, numberOfMangeoire: 0, numberOfRoue: 0);
    var resultDormir = run(Status.dormir);
    endResult = endResult.add(
        resultDormir); //faire tourner une fois avec situation intitale dormir
    print('Resultat dormir : ${resultDormir.toString()}');
    print(
        '-------------------------------------------------------------------------');
    var resultReveil = run(Status.reveil);

    endResult = endResult.add(resultReveil); //une fois avec reveil
    print('Resultat reveil : ${resultReveil.toString()}');
    print(
        '-------------------------------------------------------------------------');
    var resultManger = run(Status.manger);

    endResult = endResult.add(resultManger); //manger
    print('Resultat manger : ${resultManger.toString()}');
    print(
        '-------------------------------------------------------------------------');

    var resultExercice = run(Status.exercice);
    endResult = endResult.add(resultExercice);
    print('Resultat exerice : ${resultExercice.toString()}');
    print(
        '-------------------------------------------------------------------------');

    print('Resultat final : ${endResult.toString()}');
  }

  start();
}

enum Status {
  dormir,
  reveil,
  manger,
  exercice,
}

class Resultat {
  int numberOfDormir;
  int numberOfMangeoire;
  int numberOfRoue;
  @override
  String toString() {
    var probaDodo =
        (numberOfDormir / (numberOfDormir + numberOfMangeoire + numberOfRoue));
    var probaManger =
        numberOfMangeoire / (numberOfDormir + numberOfMangeoire + numberOfRoue);

    var probaExercice =
        numberOfRoue / (numberOfDormir + numberOfMangeoire + numberOfRoue);
    double arrondir(double nombre) {
      return (nombre * 100);
    }

    return 'copeaux : $numberOfDormir\nmangeoire : $numberOfMangeoire\nla roue : $numberOfRoue' +
        '\nprobabilité : copeaux    : ${arrondir(probaDodo)}  %' +
        '\n              mangeoire  : ${arrondir(probaManger)}  %' +
        '\n              roue       : ${arrondir(probaExercice)}  %';
  }

  Resultat add(Resultat currentResult) {
    return Resultat(
        numberOfDormir: numberOfDormir + currentResult.numberOfDormir,
        numberOfMangeoire: numberOfMangeoire + currentResult.numberOfMangeoire,
        numberOfRoue: numberOfRoue + currentResult.numberOfRoue);
  }

  Resultat({
    required this.numberOfDormir,
    required this.numberOfMangeoire,
    required this.numberOfRoue,
  });
}
