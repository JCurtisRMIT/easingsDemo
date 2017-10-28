import processing.svg.*;
import processing.opengl.*;
import controlP5.*;
import java.util.*;

ControlP5 cp5;

PFont mono;
// The font "andalemo.ttf" must be located in the 
// current sketch's "data" directory to load successfully

boolean record = false;
boolean hide = true;
//boolean svg = false;
boolean line =false;
boolean gradient =false;
boolean gridEase = false;
boolean gridLevin1 = false;
boolean gridLevin2 = false;

int func;
int funcbox;

String funcstr;

float ga = 0.0;
float gb = 0.0;
float gc = 0.0;
float gd = 0.0;
int gn = 20;

float x;
double xx = 0;
int boxwidth;



void setup(){
  //size(800,800,P2D);
  fullScreen(P3D);
  pixelDensity(2);
  smooth();
  mono = createFont("andalemo.ttf", 32);

  
  //translate(0,height);
  
  cp5 = new ControlP5(this);
  List l = Arrays.asList("linear", "easeInQuad", "easeOutQuad", "easeInOutQuad", "easeOutInQuad", "easeInCubic", "easeOutCubic", 
                         "easeInOutCubic", "easeOutInCubic", "easeInQuart", "easeOutQuart", "easeInOutQuart", "easeOutInQuart", 
                         "easeInQuint", "easeOutQuint", "easeInOutQuint", "easeOutInQuint", 
                         "easeInSine", "easeOutSine", "easeInOutSine", "easeOutInSine",
                         "easeInExpo", "easeOutExpo", "easeInOutExpo", "easeOutInExpo",
                         "easeInCirc", "easeOutCirc", "easeInOutCirc", "easeOutInCirc",
                         "easeInElastic", "easeOutElastic", "easeInOutElastic", "easeOutInElastic",
                         "easeInBack", "easeOutBack", "easeInOutBack", "easeOutInBack",
                         "easeInBounce", "easeOutBounce", "easeInOutBounce", "easeOutInBounce",
                         "blinnWyvillCosineApproximation", "doubleCubicSeat", "doubleCubicSeatWithLinearBlend",
                         "doubleOddPolynomialSeat", "doublePolynomialSigmoid", "quadraticThroughAGivenPoint",
                         "exponentialEasing", "doubleExponentialSeat", "doubleExponentialSigmoid", "logisticSigmoid",
                         "circularEaseIn", "circularEaseOut", "doubleCircleSeat", "doubleCircleSigmoid", "doubleEllipticSeat",
                         "doubleEllipticSigmoid", "circularFillet", "circularArcThroughAPoint", "quadraticBezier", 
                         "cubicBezier", "cubicBezierNearlyThroughTwoPoints");
                         
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("dropdown")
     .setPosition(10, 70)
     .setSize(200, 100)
     .setBarHeight(10)
     .setItemHeight(10)
     .addItems(l)
     // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
     ;
     
  cp5.addSlider("ga")
     .setPosition(10,10)
     .setRange(0.0,1.0)
     ;
  cp5.addSlider("gb")
     .setPosition(10,20)
     .setRange(0.0,1.0)
     ;
  cp5.addSlider("gc")
     .setPosition(10,30)
     .setRange(0.0,1.0)
     ;
  cp5.addSlider("gd")
     .setPosition(10,40)
     .setRange(0.0,1.0)
     ;
  cp5.addSlider("gn")
     .setPosition(10,50)
     .setRange(0,20)
     ;
  cp5.addToggle("line")
     .setPosition(130,10)
     .setValue(false)
     ;
  cp5.addToggle("gradient")
     .setPosition(170,10)
     .setValue(false)
     ;
  cp5.addToggle("gridEase")
     .setPosition(130,30)
     .setValue(false)
     ;
  cp5.addToggle("gridLevin1")
     .setPosition(170,30)
     .setValue(false)
     ;
  cp5.addToggle("gridLevin2")
     .setPosition(210,30)
     .setValue(false)
     ;
  cp5.show();
}

    
void draw(){
    
    if(record) {
      PGraphicsSVG pdf = (PGraphicsSVG)beginRaw(SVG, funcstr+"####.svg");
      pdf.hint(ENABLE_DEPTH_SORT);
      //pdf.setSize(1440,900);
      // set default Illustrator stroke styles and paint background rect.
      pdf.strokeJoin(MITER);
      pdf.strokeCap(MITER);
      pdf.fill(0);
      //pdf.noStroke();
      //pdf.rect(0,0, width,height);
    }
  
    
  background(0);
  pushMatrix();
  translate(0,height);
  
  //gridLevin1
    if(gridLevin1){
     line = false;
     gradient = false;
     gridEase = false;
     gridLevin2 = false;
     boxwidth = 150;
     
     colorMode(HSB);
     textFont(mono);
     textMode(SHAPE);
     textSize(25);
     
     fill(0, 0, 255);
     text("linear", 40, -height+200);
     fill(150, 165, 255);
     text("Dynamic Functions", 40, -height+230);
     //text("easeIn", 20, -height+200);
     //fill(140, 195, 255);
     //text("easeOut", 20, -height+230);
     //fill(210, 195, 255);
     //text("easeInOut", 20, -height+260);
     //fill(254, 195, 255);
     //text("easeOutIn", 20, -height+290);
     
     textSize(14);
     fill(0, 0, 255);
     text("Blinn-Wyvill Cosine Approximation", 405, -height+185);
     text("Double Cubic Seat", 880, -height+185);
     textSize(10);
     text("a: " + ga, 940, -height+225);
     text("b: " + gb, 940, -height+235);
     
     textSize(14);
     text("Double Cubic Seat with Linear Blend", 1080, -height+185);
     textSize(10);
     text("a: " + ga, 1285, -height+225);
     text("b: " + gb, 1285, -height+235);
     
     textSize(14);
     text("Double Odd Polynomial Seat", 460, -height+485);
     textSize(10);
     text("a: " + ga, 595, -height+525);
     text("b: " + gb, 595, -height+535);
     text("n: " + gn, 595, -height+545);
     
     textSize(14);
     text("Double Polynomial Sigmoid", 815, -height+485);
     textSize(10);
     text("a: " + ga, 935, -height+525);
     text("b: " + gb, 935, -height+535);
     text("n: " + gn, 935, -height+545);
     
     textSize(14);
     text("Quadratic Through A Given Point", 1110, -height+485);
     textSize(10);
     text("a: " + ga, 1285, -height+525);
     text("b: " + gb, 1285, -height+535);
     
     textSize(14);
     text("Modified Logistic Sigmoid", 125, -height+785);
     textSize(10);
     text("a: " + ga, 250, -height+825);
     
     textSize(14);
     text("Exponential Emphasis", 510, -height+785);
     textSize(10);
     text("a: " + ga, 595, -height+825);
     
     textSize(14);
     
     text("Double Exponential Seat", 835, -height+785);
     textSize(10);
     text("a: " + ga, 940, -height+825);
     
     textSize(14);
     text("Double Exponential Sigmoid", 1155, -height+785);
     textSize(10);
     text("a: " + ga, 1285, -height+825);
     
     colorMode(RGB);
     stroke(255);
     noFill();
     //strokeWeight(2.0);
     translate(0,-height+20);
     
     //rect(0, 0, boxwidth, 20);
     //rect(0, 40, 150, 150);
     
     funcbox = 0;
    
    for(int n = 0; n < 3; n++){
      pushMatrix();
      translate(0, (boxwidth*2)*n);
      
      for(int m = 0; m < 3; m++){ 
        pushMatrix();
        translate(boxwidth+220, 0);
        translate((m * (boxwidth*2.3)), 0); 
        
        stroke(255, 255, 255);
        line(0,boxwidth,boxwidth*2, 0);
        line(0,boxwidth,0, 0);
        line(0,boxwidth,boxwidth*2, boxwidth);
        
        
 
           funcbox = (n*3) + (m+41);
           println(funcbox);
           for(int k = 0; k < boxwidth*2; k++){
             //linebox
             float j = float(k)/float(boxwidth*2);
    
             funcSwitch(funcbox, j);
             x = (float) xx;
             colorMode(HSB);
             stroke(150, 165, 255);
             ellipse(k, -(x*boxwidth)+boxwidth, 1.0, 1.0);
             //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
             stroke(150, 165, x*255);
             line(k, boxwidth+(20), k, boxwidth+20+20);
             colorMode(RGB);
           }
       popMatrix();
      }
      popMatrix();
    }
    
   pushMatrix();
   translate(25, height-300);
   stroke(255, 255, 255);
   line(0,boxwidth,boxwidth*2, 0);
   line(0,boxwidth,0, 0);
   line(0,boxwidth,boxwidth*2, boxwidth);  
   funcbox = 50;
   //println(funcbox);
   for(int k = 0; k < boxwidth*2; k++){
     //linebox
     float j = float(k)/float(boxwidth*2);

     funcSwitch(funcbox, j);
     x = (float) xx;
     colorMode(HSB);
     stroke(150, 165, 255);
     ellipse(k, -(x*boxwidth)+boxwidth, 1.0, 1.0);
     //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
     stroke(150, 165, x*255);
     line(k, boxwidth+(20), k, boxwidth+20+20);
     colorMode(RGB);  
     
     
   }
   popMatrix();
    
  }
  

  //gridLevin2
    if(gridLevin2){
     line = false;
     gradient = false;
     gridEase = false;
     gridLevin1 = false;
     boxwidth = 150;
     
     colorMode(HSB);
     textFont(mono);
     //textMode(SHAPE);
     textSize(25);
     
     fill(0, 0, 255);
     text("linear", 40, -height+200);
     fill(150, 165, 255);
     text("Dynamic Functions", 40, -height+230);
     
     textSize(14);
     fill(0, 0, 255);
     text("Circular EaseIn", 550, -height+185);
     text("Circular EaseOut", 890, -height+185);
     text("Double Circular Seat", 1200, -height+185);
     textSize(10);
     text("a: " + ga, 1280, -height+225);
     
     textSize(14);
     text("Cubic Bezier", 230, -height+485);
     textSize(10);
     text("a: " + ga, 145, -height+525);
     text("b: " + gb, 145, -height+535);
     text("c: " + gc, 245, -height+525);
     text("d: " + gd, 245, -height+535);
     
     textSize(14);
     text("Double Circular Sigmoid", 487, -height+485);
     textSize(10);
     text("a: " + ga, 592, -height+525);
     
     textSize(14);
     text("Double Elliptical Seat", 840, -height+485);
     textSize(10);
     text("a: " + ga, 935, -height+525);
     text("b: " + gb, 935, -height+535);
     
     textSize(14);
     text("Double Elliptical Sigmoid", 1160, -height+485);
     textSize(10);
     text("a: " + ga, 1280, -height+525);
     text("b: " + gb, 1280, -height+535);
     
     textSize(14);
     text("Cubic Bezier Nearly Through Two Points", 20, -height+785);
     textSize(10);
     text("a: " + ga, 145, -height+825);
     text("b: " + gb, 145, -height+835);
     text("c: " + gc, 245, -height+825);
     text("d: " + gd, 245, -height+835);
     
     textSize(14);
     text("Double Linear With Circular Fillet", 380, -height+785);
     textSize(10);
     text("a: " + ga, 500, -height+825);
     text("b: " + gb, 500, -height+835);
     text("d: " + gd, 590, -height+825);
     
     textSize(14);
     text("Circular Arc Through A Point", 792, -height+785);
     textSize(10);
     text("a: " + ga, 937, -height+825);
     text("b: " + gb, 937, -height+835);
     
     textSize(14);
     text("Quadratic Bezier", 1235, -height+785);
     textSize(10);
     text("a: " + ga, 1285, -height+825);
     text("b: " + gb, 1285, -height+835);
     
     colorMode(RGB);
     stroke(255);
     noFill();
     //strokeWeight(2.0);
     translate(0,-height+20);
     
     //rect(0, 0, boxwidth, 20);
     //rect(0, 40, 150, 150);
     
     funcbox = 0;
    
    for(int n = 0; n < 3; n++){
      pushMatrix();
      translate(0, (boxwidth*2)*n);
      
      for(int m = 0; m < 3; m++){ 
        pushMatrix();
        translate(boxwidth+220, 0);
        translate((m * (boxwidth*2.3)), 0); 
        
        stroke(255, 255, 255);
        line(0,boxwidth,boxwidth*2, 0);
        line(0,boxwidth,0, 0);
        line(0,boxwidth,boxwidth*2, boxwidth);
        
        
 
           funcbox = (n*3) + (m+51);
           //println(funcbox);
           for(int k = 0; k < boxwidth*2; k++){
             //linebox
             float j = float(k)/float(boxwidth*2);
    
             funcSwitch(funcbox, j);
             x = (float) xx;
             colorMode(HSB);
             stroke(150, 165, 255);
             
             //ellipse(k, -(x*boxwidth)+boxwidth, 0.01, 0.01);
             ellipse(k, boxwidth-(x*boxwidth), 1.0, 1.0);
             
             //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
             stroke(150, 165, x*255);
             line(k, boxwidth+(20), k, boxwidth+20+20);
             fill(0, 0, 255);
             colorMode(RGB);
           }
       popMatrix();
      }
      popMatrix();
    }
    
   pushMatrix();
   translate(25, height-300);
   stroke(255, 255, 255);
   line(0,boxwidth,boxwidth*2, 0);
   line(0,boxwidth,0, 0);
   line(0,boxwidth,boxwidth*2, boxwidth);  
   funcbox = 61;
   //println(funcbox);
   for(int k = 0; k < boxwidth*2; k++){
     //linebox
     float j = float(k)/float(boxwidth*2);

     funcSwitch(funcbox, j);
     x = (float) xx;
     colorMode(HSB);
     stroke(150, 165, 255);
     ellipse(k, -(x*boxwidth)+boxwidth, 1.0, 1.0);
     //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
     stroke(150, 165, x*255);
     line(k, boxwidth+(20), k, boxwidth+20+20);
     colorMode(RGB);  
     
     
   }
   popMatrix();
    
   pushMatrix();
   translate(25, height-600);
   stroke(255, 255, 255);
   line(0,boxwidth,boxwidth*2, 0);
   line(0,boxwidth,0, 0);
   line(0,boxwidth,boxwidth*2, boxwidth);  
   funcbox = 60;
   //println(funcbox);
   for(int k = 0; k < boxwidth*2; k++){
     //linebox
     float j = float(k)/float(boxwidth*2);

     funcSwitch(funcbox, j);
     x = (float) xx;
     colorMode(HSB);
     stroke(150, 165, 255);
     ellipse(k, -(x*boxwidth)+boxwidth, 1.0, 1.0);
     //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
     stroke(150, 165, x*255);
     line(k, boxwidth+(20), k, boxwidth+20+20);
     colorMode(RGB);  
     
     
   }
   popMatrix(); 
    
    
  }



    
  //gridEase
  if(gridEase){
     line = false;
     gradient = false;
     gridLevin1 = false;
     gridLevin2 = false;
     boxwidth = 150;
     
     colorMode(HSB);
     textFont(mono);
     textMode(SHAPE);
     textSize(25);
     
     fill(0, 0, 255);
     text("linear", 40, -height+200);
     fill(70, 195, 255);
     text("easeIn", 40, -height+230);
     fill(140, 195, 255);
     text("easeOut", 40, -height+260);
     fill(210, 195, 255);
     text("easeInOut", 40, -height+290);
     fill(254, 195, 255);
     text("easeOutIn", 40, -height+320);
     
     textSize(14);
     fill(0, 0, 255);
     text("Quadratic", 600, -height+185);
     text("Cubic", 975, -height+185);
     text("Quartic", 1305, -height+185);
     
     text("Quintic", 615, -height+485);
     text("Sine", 983, -height+485);
     text("Exponential", 1273, -height+485);
     
     text("Bounce", 277, -height+785);
     text("Circular", 607, -height+785);
     text("Elastic", 962, -height+785);
     text("Back", 1327, -height+785);
     
     colorMode(RGB);
     stroke(255);
     noFill();
     //strokeWeight(2.0);
     translate(0,-height+20);
     
     //rect(0, 0, boxwidth, 20);
     //rect(0, 40, 150, 150);
     
     funcbox = 0;
    
    for(int n = 0; n < 3; n++){
      pushMatrix();
      translate(0, (boxwidth*2)*n);
      
      for(int m = 0; m < 3; m++){ 
        pushMatrix();
        translate(boxwidth+220, 0);
        translate((m * (boxwidth*2.3)), 0); 
        
        stroke(255, 255, 255);
        line(0,boxwidth,boxwidth*2, 0);
        line(0,boxwidth,0, 0);
        line(0,boxwidth,boxwidth*2, boxwidth);
        
        
        for(int l = 1; l < 5; l++){   
           funcbox = (n*12)+(m*4)+l;
           //println(funcbox);
           for(int k = 0; k < boxwidth*2; k++){
             //linebox
             float j = float(k)/float(boxwidth*2);
    
             funcSwitch(funcbox, j);
             x = (float) xx;
             colorMode(HSB);
             stroke(l*70, 195, 255);
             ellipse(k, -(x*boxwidth)+boxwidth, 1.0, 1.0);
             //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
             stroke(l*70, 195, x*255);
             line(k, boxwidth+(l*20), k, boxwidth+l*20+20);
             colorMode(RGB);
           }
        
        }
       popMatrix();
      }
      popMatrix();
    }
    
   pushMatrix();
   translate(25, height-300);
   stroke(255, 255, 255);
   line(0,boxwidth,boxwidth*2, 0);
   line(0,boxwidth,0, 0);
   line(0,boxwidth,boxwidth*2, boxwidth);
   for(int l = 1; l < 5; l++){   
   funcbox = 36+l;
   //println(funcbox);
   for(int k = 0; k < boxwidth*2; k++){
     //linebox
     float j = float(k)/float(boxwidth*2);

     funcSwitch(funcbox, j);
     x = (float) xx;
     colorMode(HSB);
     stroke(l*70, 195, 255);
     ellipse(k, -(x*boxwidth)+boxwidth, 1.0, 1.0);
     //line(k, -(x*boxwidth)+boxwidth+40, k+0.5, -(x*boxwidth)+boxwidth+40+0.5);
     stroke(l*70, 195, x*255);
     line(k, boxwidth+(l*20), k, boxwidth+l*20+20);
     colorMode(RGB);  
     
     
     }
   }
   popMatrix();
}
    
    
    for(int i=0;i<width;i++){

      fill(255);
      stroke(255);
      float j = float(i)/float(width);
  
      funcSwitch(func, j);
      
      x = (float) xx; 
      //lineonly
      if(line){stroke(255,0,0);
               ellipse(i, -(x*height), 1, 1); }
      
      //line gradient
      if(gradient){stroke(x*255);
                   line(i, 0, i, -height);}
      
  
      
      //fill only (from bottom)
      //line(i, 0, i, -(x*height));
      
      //fill pixel array (notworking)
      //for(int k=0;k<height;k+=2){
      //  ellipse(i,-k,5*x,5*x);
      //}
      
      //red linear
      //stroke(255,0,0);
      //line(0, 0, width, -height);

  }
  popMatrix();
  
  if(record) {
    endRaw();
    record=false;
  }
}
  
void dropdown(int n) {
  /* request the selected item based on index n */
  //println(n, cp5.get(ScrollableList.class, "dropdown").getItem(n));
  
  /* here an item is stored as a Map  with the following key-value pairs:
   * name, the given name of the item
   * text, the given text of the item by default the same as name
   * value, the given value of the item, can be changed by using .getItem(n).put("value", "abc"); a value here is of type Object therefore can be anything
   * color, the given color of the item, how to change, see below
   * view, a customizable view, is of type CDrawable 
   */
  
  func = (int)cp5.get(ScrollableList.class, "dropdown").getItem(n).get("value");
  println(func);
  
  funcstr = (String)cp5.get(ScrollableList.class, "dropdown").getItem(n).get("name");
  
  //CColor c = new CColor();
  //c.setBackground(color(255,0,0));
  //cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
  
}
    
    /**
     * Easing equation function for a simple linear tweening, with no easing.
     *
     * @param t    Current time (in frames or seconds).
     * @param b    Starting value.
     * @param c    Change needed in value.
     * @param d    Expected easing duration (in frames or seconds).
     * @return    The correct value.
     */
    double linear (double t,double  b,double  c,double  d) {
      return c*t/d + b;
    }
  
    /**
     * Easing equation function for a quadratic (t^2) easing in: accelerating from zero velocity.
     *
     * @param t    Current time (in frames or seconds).
     * @param b    Starting value.
     * @param c    Change needed in value.
     * @param d    Expected easing duration (in frames or seconds).
     * @return    The correct value.
     */
    double easeInQuad (double t,double  b,double  c,double d) {
      return c*(t/=d)*t + b;
    }
  
    /**
     * Easing equation function for a quadratic (t^2) easing out: decelerating to zero velocity.
     *
     * @param t    Current time (in frames or seconds).
     * @param b    Starting value.
     * @param c    Change needed in value.
     * @param d    Expected easing duration (in frames or seconds).
     * @return    The correct value.
     */
    double easeOutQuad (double t,double  b,double  c,double d) {
      return -c *(t/=d)*(t-2) + b;
    }
  

    double easeInOutQuad (double t,double  b,double  c,double d) {
      if ((t/=d/2) < 1) return c/2*t*t + b;
      return -c/2 * ((--t)*(t-2) - 1) + b;
    }
  

    double easeOutInQuad (double t,double  b,double  c,double d){
      if (t < d/2) return easeOutQuad (t*2, b, c/2, d);
      return easeInQuad((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInCubic (double t,double  b,double  c,double d) {
      return c*(t/=d)*t*t + b;
    }
  

    double easeOutCubic (double t,double  b,double  c,double d) {
      return c*((t=t/d-1)*t*t + 1) + b;
    }
  

    double easeInOutCubic (double t,double  b,double  c,double d) {
      if ((t/=d/2) < 1) return c/2*t*t*t + b;
      return c/2*((t-=2)*t*t + 2) + b;
    }
  

    double easeOutInCubic (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutCubic (t*2, b, c/2, d);
      return easeInCubic((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInQuart (double t,double  b,double  c,double d) {
      return c*(t/=d)*t*t*t + b;
    }
  

    double easeOutQuart (double t,double  b,double  c,double d) {
      return -c * ((t=t/d-1)*t*t*t - 1) + b;
    }
  

    double easeInOutQuart (double t,double  b,double  c,double d) {
      if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
      return -c/2 * ((t-=2)*t*t*t - 2) + b;
    }
  

    double easeOutInQuart (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutQuart (t*2, b, c/2, d);
      return easeInQuart((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInQuint (double t,double  b,double  c,double d) {
      return c*(t/=d)*t*t*t*t + b;
    }
  

    double easeOutQuint (double t,double  b,double  c,double d) {
      return c*((t=t/d-1)*t*t*t*t + 1) + b;
    }
  

    double easeInOutQuint (double t,double  b,double  c,double d) {
      if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
      return c/2*((t-=2)*t*t*t*t + 2) + b;
    }
  

    double easeOutInQuint (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutQuint (t*2, b, c/2, d);
      return easeInQuint((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInSine (double t,double  b,double  c,double d) {
      return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
    }
  

    double easeOutSine (double t,double  b,double  c,double d) {
      return c * Math.sin(t/d * (Math.PI/2)) + b;
    }
  

    double easeInOutSine (double t,double  b,double  c,double d) {
      return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
    }
  

    double easeOutInSine (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutSine (t*2, b, c/2, d);
      return easeInSine((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInExpo (double t,double  b,double  c,double d) {
      return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b - c * 0.001;
    }
  

    double easeOutExpo (double t,double  b,double  c,double d) {
      return (t==d) ? b+c : c * 1.001 * (-Math.pow(2, -10 * t/d) + 1) + b;
    }
  

    double easeInOutExpo (double t,double  b,double  c,double d) {
      if (t==0) return b;
      if (t==d) return b+c;
      if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b - c * 0.0005;
      return c/2 * 1.0005 * (-Math.pow(2, -10 * --t) + 2) + b;
    }
  

    double easeOutInExpo (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutExpo (t*2, b, c/2, d);
      return easeInExpo((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInCirc (double t,double  b,double  c,double d) {
      return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
    }
  

    double easeOutCirc (double t,double  b,double  c,double d) {
      return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
    }
  

    double easeInOutCirc (double t,double  b,double  c,double d) {
      if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
      return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
    }
  

    double easeOutInCirc (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutCirc (t*2, b, c/2, d);
      return easeInCirc((t*2)-d, b+c/2, c/2, d);
    }
  

    double easeInElastic (double t,double  b,double  c,double d, double a, double p) {
      if (t==0) return b;  if ((t/=d)==1) return b+c;  if (p==0.0f) p=d*.3;
      double s = 0.0f;
      if (a == 0.0f || a < Math.abs(c)) { a=c; s=p/4; }
      else s = p/(2*Math.PI) * Math.asin (c/a);
      return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
    }

    double easeOutElastic (double t,double  b,double  c,double d, double a, double p) {
      if (t==0) return b;  if ((t/=d)==1) return b+c;  if (p==0.0f) p=d*.3;
      double s = 0.0f;
      if (a == 0.0f || a < Math.abs(c)) { a=c; s=p/4; }
      else s = p/(2*Math.PI) * Math.asin (c/a);
      return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b);
    }  

    double easeInOutElastic (double t,double  b,double  c,double d, double a, double p) {
      if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (p==0.0f) p=d*(.3*1.5);
      double s = 0.0f;
      if (a==0.0f || a < Math.abs(c)) { a=c; s=p/4; }
      else s = p/(2*Math.PI) * Math.asin (c/a);
      if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
      return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
    }
    double easeOutInElastic (double t,double  b,double  c,double d, double a, double p, double s) {
      if (t < d/2) return easeOutElastic (t*2, b, c/2, d, a, p);
      return easeInElastic((t*2)-d, b+c/2, c/2, d, a, p);
    }
    double easeInBack (double t,double  b,double  c,double d, double s) {
      if (s==0.0f) s = 1.70158;
      return c*(t/=d)*t*((s+1)*t - s) + b;
    }
    double easeOutBack (double t,double  b,double  c,double d, double s) {
      if (s==0.0f) s = 1.70158;
      return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    }
    double easeInOutBack (double t,double  b,double  c,double d, double s) {
      if (s==0.0f) s = 1.70158;
      if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
      return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
    }
    double easeOutInBack (double t,double  b,double  c,double d, double s) {
      if (t < d/2) return easeOutBack (t*2, b, c/2, d, s);
      return easeInBack((t*2)-d, b+c/2, c/2, d, s);
    }
    double easeInBounce (double t,double  b,double  c,double d) {
      return c - easeOutBounce (d-t, 0, c, d) + b;
    }
    double easeOutBounce (double t,double  b,double  c,double d) {
      if ((t/=d) < (1/2.75)) {
        return c*(7.5625*t*t) + b;
      } else if (t < (2/2.75)) {
        return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
      } else if (t < (2.5/2.75)) {
        return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
      } else {
        return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
      }
    }
    double easeInOutBounce (double t,double  b,double  c,double d) {
      if (t < d/2) return easeInBounce (t*2, 0, c, d) * .5 + b;
      else return easeOutBounce (t*2-d, 0, c, d) * .5 + c*.5 + b;
    }
    double easeOutInBounce (double t,double  b,double  c,double d) {
      if (t < d/2) return easeOutBounce (t*2, b, c/2, d);
      return easeInBounce((t*2)-d, b+c/2, c/2, d);
    }

// Golan Levin's Functions

float blinnWyvillCosineApproximation (float x){
  float x2 = x*x;
  float x4 = x2*x2;
  float x6 = x4*x2;
  
  final float fa = ( 4.0/9.0);
  final float fb = (17.0/9.0);
  final float fc = (22.0/9.0);
  
  float y = fa*x6 - fb*x4 + fc*x2;
  return y;
}

float doubleCubicSeat (float x, float a, float b){
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = min(max_param_a, max(min_param_a, a));  
  b = min(max_param_b, max(min_param_b, b)); 
  
  float y = 0;
  if (x <= a){
    y = b - b*pow(1-x/a, 3.0);
  } else {
    y = b + (1-b)*pow((x-a)/(1-a), 3.0);
  }
  return y;
}

float doubleCubicSeatWithLinearBlend (float x, float a, float b){

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = min(max_param_a, max(min_param_a, a));  
  b = min(max_param_b, max(min_param_b, b)); 
  b = 1.0 - b; //reverse for intelligibility.
  
  float y = 0;
  if (x<=a){
    y = b*x + (1-b)*a*(1-pow(1-x/a, 3.0));
  } else {
    y = b*x + (1-b)*(a + (1-a)*pow((x-a)/(1-a), 3.0));
  }
  return y;
}

float doubleOddPolynomialSeat (float x, float a, float b, int n){

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = min(max_param_a, max(min_param_a, a));  
  b = min(max_param_b, max(min_param_b, b)); 

  int p = 2*n + 1;
  float y = 0;
  if (x <= a){
    y = b - b*pow(1-x/a, p);
  } else {
    y = b + (1-b)*pow((x-a)/(1-a), p);
  }
  return y;
}

//---------------------------------------------------------------
float doublePolynomialSigmoid (float x, float a, float b, int n){
  
  float y = 0;
  if (n%2 == 0){ 
    // even polynomial
    if (x<=0.5){
      y = pow(2.0*x, n)/2.0;
    } else {
      y = 1.0 - pow(2*(x-1), n)/2.0;
    }
  } 
  
  else { 
    // odd polynomial
    if (x<=0.5){
      y = pow(2.0*x, n)/2.0;
    } else {
      y = 1.0 + pow(2.0*(x-1), n)/2.0;
    }
  }

  return y;
}

float quadraticThroughAGivenPoint (float x, float a, float b){
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = min(max_param_a, max(min_param_a, a));  
  b = min(max_param_b, max(min_param_b, b)); 
  
  float A = (1-b)/(1-a) - (b/a);
  float B = (A*(a*a)-b)/a;
  float y = A*(x*x) - B*(x);
  y = min(1,max(0,y)); 
  
  return y;
}



float exponentialEasing (float x, float a){
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = max(min_param_a, min(max_param_a, a));
  
  if (a < 0.5){
    // emphasis
    a = 2.0*(a);
    float y = pow(x, a);
    return y;
  } else {
    // de-emphasis
    a = 2.0*(a-0.5);
    float y = pow(x, 1.0/(1-a));
    return y;
  }
}


float doubleExponentialSeat (float x, float a){

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = min(max_param_a, max(min_param_a, a)); 

  float y = 0;
  if (x<=0.5){
    y = (pow(2.0*x, 1-a))/2.0;
  } else {
    y = 1.0 - (pow(2.0*(1.0-x), 1-a))/2.0;
  }
  return y;
}


float doubleExponentialSigmoid (float x, float a){

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = min(max_param_a, max(min_param_a, a));
  a = 1.0-a; // for sensible results
  
  float y = 0;
  if (x<=0.5){
    y = (pow(2.0*x, 1.0/a))/2.0;
  } else {
    y = 1.0 - (pow(2.0*(1.0-x), 1.0/a))/2.0;
  }
  return y;
}

float logisticSigmoid (float x, float a){
  // n.b.: this Logistic Sigmoid has been normalized.

  float epsilon = 0.0001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = max(min_param_a, min(max_param_a, a));
  a = (1/(1-a) - 1);

  float A = 1.0 / (1.0 + exp(0 -((x-0.5)*a*2.0)));
  float B = 1.0 / (1.0 + exp(a));
  float C = 1.0 / (1.0 + exp(0-a)); 
  float y = (A-B)/(C-B);
  return y;
}

//------------------------------
float circularEaseIn (float x){
  float y = 1 - sqrt(1 - x*x);
  return y;
}

//------------------------------
float circularEaseOut (float x){
  float y = sqrt(1 - sq(1 - x));
  return y;
}

//----------------------------------------
float doubleCircleSeat (float x, float a){
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  a = max(min_param_a, min(max_param_a, a)); 

  float y = 0;
  if (x<=a){
    y = sqrt(sq(a) - sq(x-a));
  } else {
    y = 1 - sqrt(sq(1-a) - sq(x-a));
  }
  return y;
}

//-------------------------------------------
float doubleCircleSigmoid (float x, float a){
  float min_param_a = 0.0;
  float max_param_a = 1.0;
  a = max(min_param_a, min(max_param_a, a)); 

  float y = 0;
  if (x<=a){
    y = a - sqrt(a*a - x*x);
  } else {
    y = a + sqrt(sq(1-a) - sq(x-1));
  }
  return y;
}

//---------------------------------------------------
float doubleEllipticSeat (float x, float a, float b){
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = max(min_param_a, min(max_param_a, a)); 
  b = max(min_param_b, min(max_param_b, b)); 

  float y = 0;
  if (x<=a){
    y = (b/a) * sqrt(sq(a) - sq(x-a));
  } else {
    y = 1- ((1-b)/(1-a))*sqrt(sq(1-a) - sq(x-a));
  }
  return y;
}

//------------------------------------------------------
float doubleEllipticSigmoid (float x, float a, float b){

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;
  a = max(min_param_a, min(max_param_a, a)); 
  b = max(min_param_b, min(max_param_b, b));
 
  float y = 0;
  if (x<=a){
    y = b * (1 - (sqrt(sq(a) - sq(x))/a));
  } else {
    y = b + ((1-b)/(1-a))*sqrt(sq(1-a) - sq(x-1));
  }
  return y;
}

//--------------------------------------------------------
// Joining Two Lines with a Circular Arc Fillet
// Adapted from Robert D. Miller / Graphics Gems III.

float arcStartAngle;
float arcEndAngle;
float arcStartX,  arcStartY;
float arcEndX,    arcEndY;
float arcCenterX, arcCenterY;
float arcRadius;

//--------------------------------------------------------
float circularFillet (float x, float a, float b, float R){
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0 + epsilon;
  float max_param_b = 1.0 - epsilon;
  a = max(min_param_a, min(max_param_a, a)); 
  b = max(min_param_b, min(max_param_b, b)); 

  computeFilletParameters (0,0, a,b, a,b, 1,1,  R);
  float t = 0;
  float y = 0;
  x = max(0, min(1, x));
  
  if (x <= arcStartX){
    t = x / arcStartX;
    y = t * arcStartY;
  } else if (x >= arcEndX){
    t = (x - arcEndX)/(1 - arcEndX);
    y = arcEndY + t*(1 - arcEndY);
  } else {
    if (x >= arcCenterX){
      y = arcCenterY - sqrt(sq(arcRadius) - sq(x-arcCenterX)); 
    } else{
      y = arcCenterY + sqrt(sq(arcRadius) - sq(x-arcCenterX)); 
    }
  }
  return y;
}

//------------------------------------------
// Return signed distance from line Ax + By + C = 0 to point P.
float linetopoint (float a, float b, float c, float ptx, float pty){
  float lp = 0.0;
  float d = sqrt((a*a)+(b*b));
  if (d != 0.0){
    lp = (a*ptx + b*pty + c)/d;
  }
  return lp;
}

//------------------------------------------
// Compute the parameters of a circular arc 
// fillet between lines L1 (p1 to p2) and
// L2 (p3 to p4) with radius R.  
// 
void computeFilletParameters (
  float p1x, float p1y, 
  float p2x, float p2y, 
  float p3x, float p3y, 
  float p4x, float p4y,
  float r){

  float c1   = p2x*p1y - p1x*p2y;
  float a1   = p2y-p1y;
  float b1   = p1x-p2x;
  float c2   = p4x*p3y - p3x*p4y;
  float a2   = p4y-p3y;
  float b2   = p3x-p4x;
  if ((a1*b2) == (a2*b1)){  /* Parallel or coincident lines */
    return;
  }

  float d1, d2;
  float mPx, mPy;
  mPx = (p3x + p4x)/2.0;
  mPy = (p3y + p4y)/2.0;
  d1 = linetopoint(a1,b1,c1,mPx,mPy);  /* Find distance p1p2 to p3 */
  if (d1 == 0.0) {
    return; 
  }
  mPx = (p1x + p2x)/2.0;
  mPy = (p1y + p2y)/2.0;
  d2 = linetopoint(a2,b2,c2,mPx,mPy);  /* Find distance p3p4 to p2 */
  if (d2 == 0.0) {
    return; 
  }

  float c1p, c2p, d;
  float rr = r;
  if (d1 <= 0.0) {
    rr= -rr;
  }
  c1p = c1 - rr*sqrt((a1*a1)+(b1*b1));  /* Line parallel l1 at d */
  rr = r;
  if (d2 <= 0.0){
    rr = -rr;
  }
  c2p = c2 - rr*sqrt((a2*a2)+(b2*b2));  /* Line parallel l2 at d */
  d = (a1*b2)-(a2*b1);

  float pCx = (c2p*b1-c1p*b2)/d; /* Intersect constructed lines */
  float pCy = (c1p*a2-c2p*a1)/d; /* to find center of arc */
  float pAx = 0;
  float pAy = 0;
  float pBx = 0;
  float pBy = 0;
  float dP,cP;

  dP = (a1*a1) + (b1*b1);        /* Clip or extend lines as required */
  if (dP != 0.0){
    cP = a1*pCy - b1*pCx;
    pAx = (-a1*c1 - b1*cP)/dP;
    pAy = ( a1*cP - b1*c1)/dP;
  }
  dP = (a2*a2) + (b2*b2);
  if (dP != 0.0){
    cP = a2*pCy - b2*pCx;
    pBx = (-a2*c2 - b2*cP)/dP;
    pBy = ( a2*cP - b2*c2)/dP;
  }

  float gv1x = pAx-pCx; 
  float gv1y = pAy-pCy;
  float gv2x = pBx-pCx; 
  float gv2y = pBy-pCy;

  float arcStart = (float) atan2(gv1y,gv1x); 
  float arcAngle = 0.0;
  float dd = (float) sqrt(((gv1x*gv1x)+(gv1y*gv1y)) * ((gv2x*gv2x)+(gv2y*gv2y)));
  if (dd != (float) 0.0){
    arcAngle = (acos((gv1x*gv2x + gv1y*gv2y)/dd));
  } 
  float crossProduct = (gv1x*gv2y - gv2x*gv1y);
  if (crossProduct < 0.0){ 
    arcStart -= arcAngle;
  }

  float arc1 = arcStart;
  float arc2 = arcStart + arcAngle;
  if (crossProduct < 0.0){
    arc1 = arcStart + arcAngle;
    arc2 = arcStart;
  }

  arcCenterX    = pCx;
  arcCenterY    = pCy;
  arcStartAngle = arc1;
  arcEndAngle   = arc2;
  arcRadius     = r;
  arcStartX     = arcCenterX + arcRadius*cos(arcStartAngle);
  arcStartY     = arcCenterY + arcRadius*sin(arcStartAngle);
  arcEndX       = arcCenterX + arcRadius*cos(arcEndAngle);
  arcEndY       = arcCenterY + arcRadius*sin(arcEndAngle);
}

//---------------------------------------------------------
// Adapted from Paul Bourke 
float m_Centerx;
float m_Centery;
float m_dRadius;

float circularArcThroughAPoint (float x, float a, float b){  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0 + epsilon;
  float max_param_b = 1.0 - epsilon;
  a = min(max_param_a, max(min_param_a, a));
  b = min(max_param_b, max(min_param_b, b));
  x = min(1.0-epsilon, max(0.0+epsilon, x));
  
  float pt1x = 0;
  float pt1y = 0;
  float pt2x = a;
  float pt2y = b;
  float pt3x = 1;
  float pt3y = 1;

  if      (!IsPerpendicular(pt1x,pt1y, pt2x,pt2y, pt3x,pt3y))    
     calcCircleFrom3Points (pt1x,pt1y, pt2x,pt2y, pt3x,pt3y);  
  else if (!IsPerpendicular(pt1x,pt1y, pt3x,pt3y, pt2x,pt2y))    
     calcCircleFrom3Points (pt1x,pt1y, pt3x,pt3y, pt2x,pt2y);  
  else if (!IsPerpendicular(pt2x,pt2y, pt1x,pt1y, pt3x,pt3y))    
     calcCircleFrom3Points (pt2x,pt2y, pt1x,pt1y, pt3x,pt3y);  
  else if (!IsPerpendicular(pt2x,pt2y, pt3x,pt3y, pt1x,pt1y))    
     calcCircleFrom3Points (pt2x,pt2y, pt3x,pt3y, pt1x,pt1y);  
  else if (!IsPerpendicular(pt3x,pt3y, pt2x,pt2y, pt1x,pt1y))    
     calcCircleFrom3Points (pt3x,pt3y, pt2x,pt2y, pt1x,pt1y);  
  else if (!IsPerpendicular(pt3x,pt3y, pt1x,pt1y, pt2x,pt2y))    
     calcCircleFrom3Points (pt3x,pt3y, pt1x,pt1y, pt2x,pt2y);  
  else { 
    return 0;
  }

  // constrain
  if ((m_Centerx > 0) && (m_Centerx < 1)){
     if (a < m_Centerx){
       m_Centerx = 1;
       m_Centery = 0;
       m_dRadius = 1;
     } else {
       m_Centerx = 0;
       m_Centery = 1;
       m_dRadius = 1;
     }
  }
  
  float y = 0;
  if (x >= m_Centerx){
    y = m_Centery - sqrt(sq(m_dRadius) - sq(x-m_Centerx)); 
  } else {
    y = m_Centery + sqrt(sq(m_dRadius) - sq(x-m_Centerx)); 
  }
  return y;
}

//----------------------
boolean IsPerpendicular(
float pt1x, float pt1y,
float pt2x, float pt2y,
float pt3x, float pt3y)
{
  // Check the given point are perpendicular to x or y axis 
  float yDelta_a = pt2y - pt1y;
  float xDelta_a = pt2x - pt1x;
  float yDelta_b = pt3y - pt2y;
  float xDelta_b = pt3x - pt2x;
  float epsilon = 0.000001;

  // checking whether the line of the two pts are vertical
  if (abs(xDelta_a) <= epsilon && abs(yDelta_b) <= epsilon){
    return false;
  }
  if (abs(yDelta_a) <= epsilon){
    return true;
  }
  else if (abs(yDelta_b) <= epsilon){
    return true;
  }
  else if (abs(xDelta_a)<= epsilon){
    return true;
  }
  else if (abs(xDelta_b)<= epsilon){
    return true;
  }
  else return false;
}

//--------------------------
void calcCircleFrom3Points (
float pt1x, float pt1y,
float pt2x, float pt2y,
float pt3x, float pt3y)
{
  float yDelta_a = pt2y - pt1y;
  float xDelta_a = pt2x - pt1x;
  float yDelta_b = pt3y - pt2y;
  float xDelta_b = pt3x - pt2x;
  float epsilon = 0.000001;

  if (abs(xDelta_a) <= epsilon && abs(yDelta_b) <= epsilon){
    m_Centerx = 0.5*(pt2x + pt3x);
    m_Centery = 0.5*(pt1y + pt2y);
    m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y));
    return;
  }

  // IsPerpendicular() assure that xDelta(s) are not zero
  float aSlope = yDelta_a / xDelta_a; 
  float bSlope = yDelta_b / xDelta_b;
  if (abs(aSlope-bSlope) <= epsilon){  
    // checking whether the given points are colinear.   
    return;
  }

  // calc center
  m_Centerx = (
     aSlope*bSlope*(pt1y - pt3y) + 
     bSlope*(pt1x + pt2x) - 
     aSlope*(pt2x+pt3x) )
     /(2* (bSlope-aSlope) );
  m_Centery = -1*(m_Centerx - (pt1x+pt2x)/2)/aSlope +  (pt1y+pt2y)/2;
  m_dRadius = sqrt(sq(m_Centerx-pt1x) + sq(m_Centery-pt1y));
}

//------------------------------------------------
float quadraticBezier (float x, float a, float b){
  // adapted from BEZMATH.PS (1993)
  // by Don Lancaster, SYNERGETICS Inc. 
  // http://www.tinaja.com/text/bezmath.html

  float epsilon = 0.00001;
  a = max(0, min(1, a)); 
  b = max(0, min(1, b)); 
  if (a == 0.5){
    a += epsilon;
  }
  
  // solve t from x (an inverse operation)
  float om2a = 1 - 2*a;
  float t = (sqrt(a*a + om2a*x) - a)/om2a;
  float y = (1-2*b)*(t*t) + (2*b)*t;
  return y;
}

//--------------------------------------------------------------
float cubicBezier (float x, float a, float b, float c, float d){

  float y0a = 0.00; // initial y
  float x0a = 0.00; // initial x 
  float y1a = b;    // 1st influence y   
  float x1a = a;    // 1st influence x 
  float y2a = d;    // 2nd influence y
  float x2a = c;    // 2nd influence x
  float y3a = 1.00; // final y 
  float x3a = 1.00; // final x 

  float A =   x3a - 3*x2a + 3*x1a - x0a;
  float B = 3*x2a - 6*x1a + 3*x0a;
  float C = 3*x1a - 3*x0a;   
  float D =   x0a;

  float E =   y3a - 3*y2a + 3*y1a - y0a;    
  float F = 3*y2a - 6*y1a + 3*y0a;             
  float G = 3*y1a - 3*y0a;             
  float H =   y0a;

  // Solve for t given x (using Newton-Raphelson), then solve for y given t.
  // Assume for the first guess that t = x.
  float currentt = x;
  int nRefinementIterations = 5;
  for (int i=0; i < nRefinementIterations; i++){
    float currentx = xFromT (currentt, A,B,C,D); 
    float currentslope = slopeFromT (currentt, A,B,C);
    currentt -= (currentx - x)*(currentslope);
    currentt = constrain(currentt, 0,1);
  } 

  float y = yFromT (currentt,  E,F,G,H);
  return y;
}

// Helper functions:
float slopeFromT (float t, float A, float B, float C){
  float dtdx = 1.0/(3.0*A*t*t + 2.0*B*t + C); 
  return dtdx;
}

float xFromT (float t, float A, float B, float C, float D){
  float x = A*(t*t*t) + B*(t*t) + C*t + D;
  return x;
}

float yFromT (float t, float E, float F, float G, float H){
  float y = E*(t*t*t) + F*(t*t) + G*t + H;
  return y;
}

//--------------------------------------
float cubicBezierNearlyThroughTwoPoints(
  float x, float a, float b, float c, float d){

  float y = 0;
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0 + epsilon;
  float max_param_b = 1.0 - epsilon;
  a = max(min_param_a, min(max_param_a, a));
  b = max(min_param_b, min(max_param_b, b));

  float x0 = 0;  
  float y0 = 0;
  float x4 = a;  
  float y4 = b;
  float x5 = c;  
  float y5 = d;
  float x3 = 1;  
  float y3 = 1;
  float x1,y1,x2,y2; // to be solved.

  // arbitrary but reasonable 
  // t-values for interior control points
  float t1 = 0.3;
  float t2 = 0.7;

  float B0t1 = B0(t1);
  float B1t1 = B1(t1);
  float B2t1 = B2(t1);
  float B3t1 = B3(t1);
  float B0t2 = B0(t2);
  float B1t2 = B1(t2);
  float B2t2 = B2(t2);
  float B3t2 = B3(t2);

  float ccx = x4 - x0*B0t1 - x3*B3t1;
  float ccy = y4 - y0*B0t1 - y3*B3t1;
  float ffx = x5 - x0*B0t2 - x3*B3t2;
  float ffy = y5 - y0*B0t2 - y3*B3t2;

  x2 = (ccx - (ffx*B1t1)/B1t2) / (B2t1 - (B1t1*B2t2)/B1t2);
  y2 = (ccy - (ffy*B1t1)/B1t2) / (B2t1 - (B1t1*B2t2)/B1t2);
  x1 = (ccx - x2*B2t1) / B1t1;
  y1 = (ccy - y2*B2t1) / B1t1;

  x1 = max(0+epsilon, min(1-epsilon, x1));
  x2 = max(0+epsilon, min(1-epsilon, x2));

  // Note that this function also requires cubicBezier()!
  y = cubicBezier (x, x1,y1, x2,y2);
  y = max(0, min(1, y));
  return y;
}

// Helper functions. 
float B0 (float t){
  return (1-t)*(1-t)*(1-t);
}
float B1 (float t){
  return  3*t* (1-t)*(1-t);
}
float B2 (float t){
  return 3*t*t* (1-t);
}
float B3 (float t){
  return t*t*t;
}
float  findx (float t, float x0, float x1, float x2, float x3){
  return x0*B0(t) + x1*B1(t) + x2*B2(t) + x3*B3(t);
}
float  findy (float t, float y0, float y1, float y2, float y3){
  return y0*B0(t) + y1*B1(t) + y2*B2(t) + y3*B3(t);
}


void funcSwitch(int func, float j){
  switch (func){
      case(0):
        xx = linear(j, 0, 1, 1);
        break;
      case(1):
        xx = easeInQuad(j, 0, 1, 1);
        break;
      case(2):
        xx = easeOutQuad(j, 0, 1, 1);
        break;
      case(3):
        xx = easeInOutQuad(j, 0, 1, 1);
        break;
      case(4):
        xx = easeOutInQuad(j, 0, 1, 1);
        break;
      case(5):
        xx = easeInCubic(j, 0, 1, 1);
        break;
      case(6):
        xx = easeOutCubic(j, 0, 1, 1);
        break;
      case(7):
        xx = easeInOutCubic(j, 0, 1, 1);
        break;
      case(8):
        xx = easeOutInCubic(j, 0, 1, 1);
        break;
      case(9):
        xx = easeInQuart(j, 0, 1, 1);
        break;
      case(10):
        xx = easeOutQuart(j, 0, 1, 1);
        break;
      case(11):
        xx = easeInOutQuart(j, 0, 1, 1);
        break;
      case(12):
        xx = easeOutInQuart(j, 0, 1, 1);
        break;
      case(13):
        xx = easeInQuint(j, 0, 1, 1);
        break;
      case(14):
        xx = easeOutQuint(j, 0, 1, 1);
        break;
      case(15):
        xx = easeInOutQuint(j, 0, 1, 1);
        break;
      case(16):
        xx = easeOutInQuint(j, 0, 1, 1);
        break;
      case(17):
        xx = easeInSine(j, 0, 1, 1);
        break;
      case(18):
        xx = easeOutSine(j, 0, 1, 1);
        break;
      case(19):
        xx = easeInOutSine(j, 0, 1, 1);
        break;
      case(20):
        xx = easeOutInSine(j, 0, 1, 1);
        break;
      case(21):
        xx = easeInExpo(j, 0, 1, 1);
        break;
      case(22):
        xx = easeOutExpo(j, 0, 1, 1);
        break;
      case(23):
        xx = easeInOutExpo(j, 0, 1, 1);
        break;
      case(24):
        xx = easeOutInExpo(j, 0, 1, 1);
        break;
      case(25):
        xx = easeInCirc(j, 0, 1, 1);
        break;
      case(26):
        xx = easeOutCirc(j, 0, 1, 1);
        break;
      case(27):
        xx = easeInOutCirc(j, 0, 1, 1);
        break;
      case(28):
        xx = easeOutInCirc(j, 0, 1, 1);
        break;
      case(29):
        xx = easeInElastic(j, 0, 1, 1, 0, 0);
        break;
      case(30):
        xx = easeOutElastic(j, 0, 1, 1, 0, 0);
        break;
      case(31):
        xx = easeInOutElastic(j, 0, 1, 1, 0, 0);
        break;
      case(32):
        xx = easeOutInElastic(j, 0, 1, 1, 0, 0, 0);
        break;
      case(33):
        xx = easeInBack(j, 0, 1, 1, 0);
        break;
      case(34):
        xx = easeOutBack(j, 0, 1, 1, 0);
        break;
      case(35):
        xx = easeInOutBack(j, 0, 1, 1, 0);
        break;
      case(36):
        xx = easeOutInBack(j, 0, 1, 1, 0);
        break;
      case(37):
        xx = easeInBounce(j, 0, 1, 1);
        break;
      case(38):
        xx = easeOutBounce(j, 0, 1, 1);
        break;
      case(39):
        xx = easeInOutBounce(j, 0, 1, 1);
        break;
      case(40):
        xx = easeOutInBounce(j, 0, 1, 1);
        break;
      case(41):
        xx = blinnWyvillCosineApproximation(j);
        break;
      case(42):
        xx = doubleCubicSeat(j, ga, gb);
        break;
      case(43):
        xx = doubleCubicSeatWithLinearBlend(j, ga, gb);
        break;
      case(44):
        xx = doubleOddPolynomialSeat(j, ga, gb, gn);
        break;
      case(45):
        xx = doublePolynomialSigmoid(j, ga, gb, gn);
        break;
      case(46):
        xx = quadraticThroughAGivenPoint(j, ga, gb);
        break;
      case(47):
        xx = exponentialEasing(j, ga);
        break;
      case(48):
        xx = doubleExponentialSeat(j, ga);
        break;
      case(49):
        xx = doubleExponentialSigmoid(j, ga);
        break;
      case(50):
        xx = logisticSigmoid(j, ga);
        break;
      case(51):
        xx = circularEaseIn(j);
        break;
      case(52):
        xx = circularEaseOut(j);
        break;
      case(53):
        xx = doubleCircleSeat(j, ga);
        break;
      case(54):
        xx = doubleCircleSigmoid(j, ga);
        break;
      case(55):
        xx = doubleEllipticSeat(j, ga, gb);
        break;
      case(56):
        xx = doubleEllipticSigmoid(j, ga, gb);
        break;
      case(57):
        xx = circularFillet(j, ga, gb, gd);
        break;
      case(58):
        xx = circularArcThroughAPoint(j, ga, gb);
        break;
      case(59):
        xx = quadraticBezier(j, ga, gb);
        break;
      case(60):
        xx = cubicBezier(j, ga, gb, gc, gd);
        break;
      case(61):
        xx = cubicBezierNearlyThroughTwoPoints(j, ga, gb, gc, gd);
        break;
    }
}

void keyPressed(){
  switch(key){
    case('z'):
      if(!hide){
         hide = true;
         cp5.show();
         break;
      } else {
        hide = false;
         cp5.hide();
         break; 
      }
    case('s'):
      //if(line) saveFrame(funcstr);
      //else 
      record = true;
      break;
  }
}