

String projectTitle = "Bouncing Ball";

float position_x = 500;
float position_y = 200;
float velocity_x = 10;
float velocity_y = 0;
float radius = 40; 
float floor = 750;

void setup(){
  size(1000, 800, P3D);
  noStroke();
}

void computePhysics(float dt){
  float acceleration = 9.8;
  float coeff = 0.95;
  
  position_x = position_x + dt * velocity_x;
 
  position_y = position_y + dt * velocity_y;
  velocity_y = velocity_y + dt * acceleration;
  
  float position_y_nxt = position_y + dt * velocity_y;
  if ( position_y_nxt + radius > floor){
    position_y = floor - radius;
    velocity_y = -1 * coeff * velocity_y; 
  }
}

void drawWall(float x, float y, float z, float w, float h){
  pushMatrix();
  translate(x,y,z);
  fill(230,100,70);
  rect(0,0, w, h);
  popMatrix();
}

void drawBox(float x, float y, float z, float w, float h, float d){
  pushMatrix();
  translate(x,y,z);
  fill(230,100,70);
  //walls
  beginShape(QUAD_STRIP);
  vertex(0,0,0);
  vertex(0,h,0);
  vertex(0,0,-d);
  vertex(0,h,-d);
  vertex(w,0,-d);
  vertex(w,h,-d);
  vertex(w,0,0);
  vertex(w,h,0);
  endShape();
  // floor
  beginShape(QUAD_STRIP);
  vertex(0,h,0);
  vertex(0,h,-d);
  vertex(w,h,0);
  vertex(w,h,-d);
  endShape();
  // roof
  beginShape(QUAD_STRIP);
  vertex(0,0,0);
  vertex(0,0,-d);
  vertex(w,0,0);
  vertex(w,0,-d);
  endShape();
  
  popMatrix();
}

void drawBall(float position_y){
  pushMatrix();
  translate(position_x, position_y, -300);
  fill(65,100,230);
  sphere(60);
  popMatrix();
}

void drawLight(){
  pushMatrix();
  pointLight(255,255,255, width/2, 60, -300);
  translate(width/2, 60, -300);
  fill(255,255,0);
  sphere(5);
  popMatrix();
}

void drawScene(){
  background(255,255,255);
  lights();
  drawLight();

  drawBox(100, 50, 0, width-200, height-100, 600);
  
  drawBall(position_y);
}

void draw(){
  float startFrame = millis();
  
  float dt = 0.15;
  computePhysics(dt);
  float endPhysics = millis();
  
  drawScene();
  float endFrame = millis();
  
  String runtimeReport = "Frame: "+str(endFrame-startFrame)+"ms,"+
        " Physics: "+ str(endPhysics-startFrame)+"ms,"+
        " FPS: "+ str(round(frameRate)) +"\n";
        
  surface.setTitle(projectTitle+ "  -  " +runtimeReport);
  //print(runtimeReport);
}
