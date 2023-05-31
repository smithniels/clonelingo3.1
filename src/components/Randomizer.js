// FISHER-YATES Shuffle Algorithm
// Creator: CoolAJ86 on stackoverflow
// https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
// Thanks! 😬
// /Users/ehiilmnsst

import Questions from "./Questions.js";

function shuffle(array) {
  let counter = array.length;
  // While there are elements in the array
  while (counter > 0) {
    // Pick a random index
    let index = Math.floor(Math.random() * counter);
    // Decrease counter by 1
    counter--;
    // And swap the last element with it
    let temp = array[counter];
    array[counter] = array[index];
    array[index] = temp;
  }
  return array;
}

var RandArray = shuffle(Questions);

export default RandArray;
