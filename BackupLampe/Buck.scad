/*
 * Konstantstromquelle 
 */

include <Utils.scad>;

buck();
 


module buck (){
  color("Blue"){
    translate ([0,0,0]){
      cylinder (h=2, r =  23 /2);
    }
  }
  color("Black"){
    translate ([0,0,2]){
     cube ([6,6,5]);
    } 
    translate ([-3,-2,2]){
     cube ([4,2,3]);
    } 
    translate ([-4,-7,2]){
     cube ([4,5,2]);
    }
  }
}





