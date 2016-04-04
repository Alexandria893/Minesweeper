import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS=20;
private final static int NUM_COLS=20;
//2d array of minesweeper buttons
private MSButton[][] buttons;
//ArrayList of just the minesweeper buttons that are mined
private ArrayList <MSButton> bombs; 
//number of bombs adjusts to number of buttons 
private int nB=NUM_ROWS*NUM_COLS/10;

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to declare and initialize buttons goes here
  buttons= new MSButton[NUM_ROWS][NUM_COLS];
  bombs= new ArrayList<MSButton>();

  for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  setBombs();
}


public void setBombs()
{
  //adjust for amount of bombs   
  while (bombs.size()<nB)
  {
    int r = (int)(Math.random()*NUM_ROWS);
    int c =(int)(Math.random()*NUM_ROWS);

    if (!bombs.contains(buttons[r][c]))
    {
    
      bombs.add(buttons[r][c]);
     //displays bombs
     // System.out.println(r+","+c);
    }
  }
}

public void draw ()
{
  background(0);
  if (isWon())
    displayWinningMessage();

}

public boolean isWon()
{
  //your code here
  return false;
}

public void displayLosingMessage()
{
  
  stroke(255,0,0);
      buttons[10][5].setLabel("G");
      buttons[10][6].setLabel("A");
      buttons[10][7].setLabel("M");
      buttons[10][8].setLabel("E");
      buttons[10][9].setLabel("O");
      buttons[10][10].setLabel("V");
      buttons[10][11].setLabel("E");
      buttons[10][12].setLabel("R");
    
}

public void displayWinningMessage()
{
      stroke(255,0,0);
      buttons[10][5].setLabel("Y");
      buttons[10][6].setLabel("O");
      buttons[10][7].setLabel("U");
      buttons[10][10].setLabel("W");
      buttons[10][11].setLabel("I");
      buttons[10][12].setLabel("N");
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
   // called by manager

  public void mousePressed()
  {
    //if `mousePressed` is `true`, toggles `marked` to either either `true` or `false`
    if (mouseButton==LEFT)
      clicked = true;
    //marks key to black for bomb
    if (mouseButton==RIGHT)
    {
      marked= !marked;
    }
    
    //else if `bombs` contains `this` button display the losing message
    else if (bombs.contains(this))
    { 
      displayLosingMessage();
    }
    //else if `countBombs` returns a number of neighboring mines greater than zero, set the label to that number
    else if (countBombs(r, c) > 0 && isMarked()==false) 
    {
      label=""+countBombs(r, c);
    }
    // else recursively call `mousePressed` with the valid, unclicked, neighboring buttons 
    else
    {
        for (int i= -1; i < 2; i++) { 
        for (int j = -1; j < 2; j++) { 
          if (isValid(r+i, c+j)==true && buttons[r+i][c+j].isClicked() == false)
          {            
              //recursively call mousepressed
              buttons[r+i][c+j].mousePressed();
            
          }
        }
      }
    }
  }
  public void draw() 
  {
     if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int row, int col)
  {
    if (row>=0 && row<NUM_ROWS && col>=0 && col<NUM_COLS)
    {
      return true;
    }  
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    for (int cc=-1; cc<2; cc++)
    {    
      for (int rr=-1; rr<2; rr++)
      {
        if (isValid(row+rr, col+cc) && bombs.contains(buttons[row+rr][col+cc]))
          numBombs++;
      }
    }        
    return numBombs;
  }
}
