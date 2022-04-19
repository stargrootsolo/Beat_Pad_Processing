class Tunnel {
  
  float rect_width = 1;
   float circle_width = 1;
   boolean rect_exists = true;
   boolean circle_exists = false;
   int increment = 5;
   int threshold = 100;
  
  Tunnel(){
     rectMode(CENTER);
     ellipseMode(CENTER);

    }
    
    
    void drawrectangle(){
       noFill();
     strokeWeight(10);
      stroke(#fddde6);
          rect(width/2, height/2, this.rect_width, this.rect_width); 
 this.rect_width += this.rect_width/this.increment; 
    
    }
    
       void drawcircle(){
             noFill();
     strokeWeight(12);
      stroke(#e7feff);
          circle(width/2, height/2, this.circle_width); 
 this.circle_width += this.circle_width/this.increment; 
    
    } 
    
       
    void display() {
      strokeWeight(2);
      point(width/2, height/2);
      if (this.rect_exists){
      this.drawrectangle();
      }
      
      if (this.rect_width > width * 2){
        this.rect_width = 1;
        this.rect_exists =false;
      
       } 
      
      if (this.rect_width > this.threshold) {
          this.circle_exists = true;
      
       } 
       if (this.circle_exists) {
        this.drawcircle();
     }
     
      if (this.circle_width > width * 2){
        this.circle_width = 1;
        this.circle_exists =false;
      
       } 
       if (this.circle_width > this.threshold) {
          this.rect_exists = true;
    }
   
  }
 }
