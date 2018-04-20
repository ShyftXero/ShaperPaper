/*
24FEB18
shyft
cheap source of shaper tape? maybe... 
*/


import processing.pdf.*;
import java.util.Collections;


void settings(){
  Marker t = new Marker(0,0);
  
  //216 × 279 mm (8.5 × 11 in) ; next line forces page to be size of paper
  size((int)t.mm(216),(int)t.mm(279), PDF, "cheap_tape.pdf");  //uncomment the exit(); in draw()
  //size(1280, 720, P2D); // for rapid development
}



void draw(){
  background(255);
  
  //adding registration marks for callibration - https://github.com/ShyftXero/ShaperPaper/issues/1
  Marker t = new Marker(0,0);
  for(int i = 25; i < 200; i = i + 25){
    line(t.mm(10), t.mm(i), t.mm(50), t.mm(i));
  }
  
  // draw a whole page
  for( int i = 10; i < width -1 ; i += 100){ 
    for( int j = 10; j < height - 1 ; j += 175){ 
      Marker m1 = new Marker(i,j);
      m1.drawPoints();      
    }
  }
  
 
  //delay(1000);
 exit();
}





class Marker{
  float xPos, yPos;
  float marker_width, marker_height;
  float GRID_SIZE = 5;
  
  public Marker(float xPos, float yPos){
    this.xPos = xPos;
    this.yPos = yPos;
    this.marker_height = mm(43);
    this.marker_width = mm(12.5);  
  }
  
  public void drawPoints(){
    fill(0);
    rect(this.xPos, this.yPos, this.marker_width, this.marker_height, 7);
    
    ArrayList<float[]> points = new ArrayList<float[]>();
    
    for (int i = 1; i < 9; i++){
      //left dot
      float[] leftDot = {this.xPos + mm(this.GRID_SIZE/2)  + mm(1), this.yPos + mm(this.GRID_SIZE * i) - mm(1.25)};
      points.add(leftDot); 

      //right dot
      float[] rightDot = {this.xPos + this.marker_width - (mm(this.GRID_SIZE/2) + mm(1)), this.yPos + mm(this.GRID_SIZE * i) -mm(1.25)};
      points.add(rightDot); 
      
    }
    
    Collections.shuffle(points);
    
    fill(255);
    
    int c = 0;
    for(float[] tmp : points){
      if (c < 10){  //we only want 10 dots. 
        println(tmp[0], tmp[1]);
        
        dot(tmp[0],tmp[1]);
      }
      c++;
    }
    
  }
  
  public void dot(float x, float y){
    ellipseMode(CENTER);  
    ellipse(x, y, mm(this.GRID_SIZE/2), mm(this.GRID_SIZE/2));
  }  
  

  //https://forum.processing.org/two/discussion/25832/set-size-in-cm-mm
  //static final float MM_TO_PIXEL_RATIO = 0.3527778f;
  static final float PIXEL_PER_MM = 3.779527559f ; //http://www.unitconversion.org/typography/pixels-x-to-millimeters-conversion.html
  public float mm(float wantedMM) {
    //return wantedMM / MM_TO_PIXEL_RATIO;
    return wantedMM * PIXEL_PER_MM;
  }
  
}
