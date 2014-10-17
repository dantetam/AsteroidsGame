//your variable declarations here
private SpaceShip player;
private Star[] stars;

public void setup() 
{
  size(800,800);
  player = new SpaceShip();
  int n = 100;
  stars = new Star[n];
  for (int i = 0; i < n; i++)
  {
    stars[i] = new Star();
  }
}

public void draw() 
{
  background(0);
  if (wp)
    player.accelerate(0.1);
  if (ap)
    player.rotate(-5);
  if (sp)
    player.accelerate(-0.1);
  if (dp)
    player.rotate(5);
  player.move();
  player.show();
  for (int i = 0; i < stars.length; i++)
  {
    stars[i].show();
  }
}

private boolean wp = false, ap = false, sp = false, dp = false;
public void keyPressed()
{
  if (key == 'w')
    wp = true;
  else if (key == 'a')
    ap = true;
  else if (key == 's')
    sp = true;
  else if (key == 'd')
    dp = true; 
}

public void keyReleased()
{
  if (key == 'w')
    wp = false;
  else if (key == 'a')
    ap = false;
  else if (key == 's')
    sp = false;
  else if (key == 'd')
    dp = false; 
  else if (key == 32)
  {
    player.setX(int(random(0,width))); player.setY(int(random(0,height)));
    player.setDirectionX(0); player.setDirectionY(0);
    player.setPointDirection(int(random(0,360)));
  }
}

class Star extends Floater
{
  public Star()
  {
    setX(int(random(0,width))); setY(int(random(0,width)));
    setDirectionX(0); setDirectionY(0);
    setPointDirection(0);
    myColor = color(255,255,255);
    corners = 4;
    xCorners = new int[4]; yCorners = new int[4];
    int size = 4;
    xCorners[0] = size; yCorners[0] = 0;
    xCorners[1] = 0; yCorners[1] = size;
    xCorners[2] = -size; yCorners[2] = 0;
    xCorners[3] = 0; yCorners[3] = -size;
  }
  
  public void setX(int x) {myCenterX = x;} 
  public void setY(int y) {myCenterY = y;} 
  public void setDirectionX(double x) {myDirectionX = x;} 
  public void setDirectionY(double y) {myDirectionY = y;} 
  public void setPointDirection(int d) {myPointDirection = d;} 
  
  public int getX() {return int(myCenterX);}
  public int getY() {return int(myCenterY);}
  public double getDirectionX() {return myDirectionX;}
  public double getDirectionY() {return myDirectionY;}
  public double getPointDirection() {return myPointDirection;}
}

class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
    setX(width/2); setY(height/2);
    setDirectionX(0); setDirectionY(0);
    setPointDirection(0);
    myColor = color(255,255,255);
    corners = 4;
    xCorners = new int[4]; yCorners = new int[4];
    int size = 10;
    xCorners[0] = size; yCorners[0] = 0;
    xCorners[1] = -size; yCorners[1] = size;
    xCorners[2] = -size/2; yCorners[2] = 0;
    xCorners[3] = -size; yCorners[3] = -size;
  }
  
  public void accelerate(double a)
  {
    double x = myDirectionX, y = myDirectionY;
    //Refer to the original accelerate function in Floater
    super.accelerate(a);
    if (myDirectionX > 8 || myDirectionY > 8)
    {
      setDirectionX(x); setDirectionY(y);
    }
  }
  
  public void move()
  {
    super.move();
    //myDirectionX = myDirectionX/1.01;
    //myDirectionY = myDirectionY/1.01;
  }
  
  public void setX(int x) {myCenterX = x;} 
  public void setY(int y) {myCenterY = y;} 
  public void setDirectionX(double x) {myDirectionX = x;} 
  public void setDirectionY(double y) {myDirectionY = y;} 
  public void setPointDirection(int d) {myPointDirection = d;} 
  
  public int getX() {return int(myCenterX);}
  public int getY() {return int(myCenterY);}
  public double getDirectionX() {return myDirectionX;}
  public double getDirectionY() {return myDirectionY;}
  public double getPointDirection() {return myPointDirection;}
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected int myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate(double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate(int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

