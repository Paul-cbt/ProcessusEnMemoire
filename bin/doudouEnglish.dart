import 'dart:math';

int numberOfRuns = 1000000;
void main(List<String> arguments) {
  Status getNextStatus(Status currentStatus) {
    var random = Random();

    switch (currentStatus) {
      case Status.sleep:
        if (random.nextInt(10) == 1) {
          //one in ten chance to wake up
          return Status.wakingUp;
        } else {
          // 9/10 chances to continue sleeping
          return Status.sleep;
        }

      case Status.wakingUp:
        if (random.nextInt(2) == 1) {
          //1/2 chances to go eat
          return Status.eating;
        } else {
          //1/2 chances to go exercice
          return Status.exercice;
        }
      case Status.eating:
        if (random.nextInt(10) < 3) {
          //3/10 chances to go exercice
          return Status.exercice;
        } else {
          ///7/10 chance to go to sleep
          return Status.sleep;
        }
      case Status.exercice:
        if (random.nextInt(10) < 2) {
          return Status.exercice;
          //2/10 chances to continue exercising
        } else {
          //8/10 chance to go to sleep
          return Status.sleep;
        }
    }
  }

  Result run(Status baseStatus) {
    //one simulating
    var currentStatus = baseStatus;
    var numberOfsleep = 0;
    var numberOfeatingPlace = 0;
    var numberOfRoue = 0;
    //no wakingUp place because it doesn't count as a location in the math exercice

    for (var i = 0; i < numberOfRuns; i++) {
      switch (currentStatus) {
        case Status.sleep:
          numberOfsleep++;
          //add one occurrence to the sleeping place
          break;
        case Status.exercice:
          numberOfRoue++;
          //add one occurrence to the exercising place

          break;
        case Status.eating:
          numberOfeatingPlace++;
          //add one occurrence to the eating place
          break;

        case Status.wakingUp:

          //waking up, not counting as step
          break;
        default:
      }
      currentStatus = getNextStatus(currentStatus);
      //use the get next status method to randomly get the next one
    }
    return Result(
        numberOfsleep: numberOfsleep,
        numberOfeatingPlace: numberOfeatingPlace,
        numberOfRoue: numberOfRoue);
  }

  void start() {
    //start all the simulations
    var endResult =
        Result(numberOfsleep: 0, numberOfeatingPlace: 0, numberOfRoue: 0);
    //initial status is not given, so we run 4 simulations with one of the status as the initial one.

    var resultsleep =
        run(Status.sleep); //simulating with sleep as initial status
    endResult = endResult.add(resultsleep);
    print('Result sleep : ${resultsleep.toString()}');
    print(
        '-------------------------------------------------------------------------');

    var resultwakingUp =
        run(Status.wakingUp); //simulating with wakingUp as initial status
    endResult = endResult.add(resultwakingUp);
    print('Result wakingUp : ${resultwakingUp.toString()}');
    print(
        '-------------------------------------------------------------------------');

    var resulteating =
        run(Status.eating); //simulating with eating as initial status
    endResult = endResult.add(resulteating);
    print('Result eating : ${resulteating.toString()}');
    print(
        '-------------------------------------------------------------------------');

    var resultExercice =
        run(Status.exercice); //simulating with exercising as initial status
    endResult = endResult.add(resultExercice);
    print('Result exerice : ${resultExercice.toString()}');
    print(
        '-------------------------------------------------------------------------');

    //give the final result, so we know where we have the most chances to find the hamster.
    print(
        'final Result with ${4 * numberOfRuns} runs : ${endResult.toString()}');
  }

  start();
}

enum Status {
  //enum all the possible status
  sleep,
  wakingUp,
  eating,
  exercice,
}

class Result {
  //as score for all the possible places where we can find the hamster
  int numberOfsleep;
  int numberOfeatingPlace;
  int numberOfRoue;
  @override
  String toString() {
    var probasleep =
        (numberOfsleep / (numberOfsleep + numberOfeatingPlace + numberOfRoue));
    var probaeating = numberOfeatingPlace /
        (numberOfsleep + numberOfeatingPlace + numberOfRoue);

    var probaExercice =
        numberOfRoue / (numberOfsleep + numberOfeatingPlace + numberOfRoue);
    double arrondir(double nombre) {
      return (nombre * 100);
    }

    return 'sleeping place : $numberOfsleep\neatingPlace : $numberOfeatingPlace\nexercising place: $numberOfRoue' +
        '\nprobability : sleeping place    : ${arrondir(probasleep)}  %' +
        '\n              eating Place  : ${arrondir(probaeating)}  %' +
        '\n              exercising place       : ${arrondir(probaExercice)}  %';
  }

  Result add(Result currentResult) {
    return Result(
        numberOfsleep: numberOfsleep + currentResult.numberOfsleep,
        numberOfeatingPlace:
            numberOfeatingPlace + currentResult.numberOfeatingPlace,
        numberOfRoue: numberOfRoue + currentResult.numberOfRoue);
  }

  Result({
    required this.numberOfsleep,
    required this.numberOfeatingPlace,
    required this.numberOfRoue,
  });
}
