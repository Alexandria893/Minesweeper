

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS=20;
private final static int NUM_COLS=20;
//2d array of minesweeper buttons
private MSButton[][] buttons;
//ArrayList of just the minesweeper buttons that are mined
private ArrayList <MSButton> bombs; 

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons= new MSButton[20][20];
    bombs= new ArrayList<MSButton>();

    for(int r=0; r<NUM_ROWS; r++)
    {
        for(int c=0; c<NUM_COLS; c++)
         {
            buttons[r][c] = new MSButton(r,c);
         }       
    }
    setBombs();
}


public void setBombs()
{
    //adjust for amount of bombs   
    while(bombs.size()<8)
    {
    int r = (int)(Math.random()*20);
    int c =(int)(Math.random()*20);
        
       if(bombs.contains(buttons[r][c]))
       {
       }
       else 
         bombs.add(buttons[r][c]);
    }
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
}

public boolean isWon()
{
    //your code here
    return false;
}

public void displayLosingMessage()
{

    //your code here


}


public void displayWinningMessage()
{

    //your code here

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
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
        //marks key to black for bomb
        clicked = true;
        //if `keyPressed` is `true`, toggles `marked` to either either `true` or `false`

        if(keyPressed==true)
            marked= !marked;
        //else if `bombs` contains `this` button display the losing message
        else if (bombs.contains(this))
        {
            displayLosingMessage();
        }
        //else if `countBombs` returns a number of neighboring mines greater than zero, set the label to that number

       else if(countBombs(r,c)>0)
        {
            setLabel(""+countBombs(r,c));
        }    
    }

    public void draw() 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int row, int col)
    {
    if(row<20 && col<20)
            {
            }  
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int cc=-1; cc<2; cc++)
        {    
            for(int rr=-1; rr<2; rr++)
             {
                if(rr !=0 && cc!=0 && isValid(row+rr,col+cc) && bombs.contains(buttons[row+rr][col+cc]))
                    numBombs++;            

             }   

        }        
        return numBombs;
    }
}



