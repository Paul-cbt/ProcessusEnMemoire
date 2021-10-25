# No Memory processes

This is just a little script for a math exercice.

**script is in /bin**

[Exécuter en ligne en fr](https://dartpad.dev/?null_safety=true&id=ee40b4a6f1eba3490f533c2f747d756a)

[Run online in english](https://dartpad.dev/?null_safety=true&id=01b1cbea887f4a3c45443eef8146041c)


# Exerice

We have a hamster and he can be in 4 differents states

 - Sleeping
 - Waking Up
 - Eating
 - Exercising
 
 ### Each "round" he can change his state:
If he is sleeping, he has 1/10 chances to wake up and 9/10 to continue sleeping
If he is waking up, he has 1/2 chances to go eat or 1/2 chances to go exercice
If he is eating, has has 3/10 chances to go exercise, and 7/10 chances to go to sleep
Lastly, if he is exercizing, he has 8/10 chances to go to sleep and 2/10 chances to continue

**No intial state is specified**

We want to know where we have the most chances to find he hamster, at his sleeping place,  at his eating place or at his exercising place.

We will run simulations for each possible initial state and look at the results.
# Result

 **output**:
 final Result :
  sleeping place : 3572936 
  eatingPlace : 162588 
  exercising place: 264476 
probability : sleeping place : 89.32339999999999 % 
					 eating Place : 4.0647 % 
					 exercising place : 6.6118999999999994 %