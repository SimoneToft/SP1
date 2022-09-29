//Classic minesweeper!

/*Width and height of the game.  (for adjusting amount of fields)
(9x9 for standard, 30x16 for expert)*/
int Width=9;
int Height=9;

//Tracking how many mines are left
int totalMines;

//For adjusting the size of the game 
int gameSize=40;

//Tracking the losing move's x and y position
int lossX, lossY;

/*Array holding values of each cell
 -1 represents a unopened cell
 0 represents a blank cell
 1-8 represents amount of mines around the cell
 9 represents a mine
 10 represents a correctly placed flag
 11 represents a incorrectly placed flag
*/
int[][] Minesweeper = new int[Width][Height];

//For checking if it's the first move, to make sure the first move is a safe open space
boolean firstMove;

//For checking if you won the game 
boolean Victory;

//Percentage chance of tile having a mine. Adjust to change number of mines
float mineChance = 0.21;

//Adjusting window size to fit size, height and width of game
int gameWidth=Width*gameSize+gameSize*2;
int gameHeight=Height*gameSize+gameSize*2;
void settings(){
  size(gameWidth,gameHeight);
}

void setup(){
  textSize(gameSize*0.70);
  ellipseMode(CENTER);
  rectMode(CORNER);
  strokeWeight(0);
  firstMove=true;
  Victory=false;
  lossX=-1;
  lossY=-1;
  
  //Rolls mines by generating a float between 0-1 and setting cell as a mine if generated number is lower than mineChance
  for (int i = 0; i < Width; i++){
        for (int j = 0; j < Height; j++){
            if (random(0,1) < mineChance){
                Minesweeper[i][j] = 9;
                totalMines++;
            }
            else{
                Minesweeper[i][j] = -1;
            }
        }
  }
}

void draw(){
  background(#bdbdbd);
  fill(#ed3415);
  text("Mines left: "+totalMines, gameSize,gameSize*0.75);
   for (int i = 0; i < Width; i++){
        for (int j = 0; j < Height; j++){
            // If cell is not a mine, display number of mines surrounding cell
            if (Minesweeper[i][j] >= 0 && Minesweeper[i][j] <= 8){
                // Setting background for opened cell
                strokeWeight(1.5);
                stroke(#727272);
                fill(#bdbdbd);
                rect(i*gameSize+gameSize,gameSize+(j*gameSize),gameSize,gameSize);
                strokeWeight(0);
                stroke(0);
                
                // Selects color for number based on amount of mines
                switch (Minesweeper[i][j]){
                    case 0: fill(250); break;
                    case 1: fill(#0032fc); break;
                    case 2: fill(#32770d); break;
                    case 3: fill(#ed3415); break;
                    case 4: fill(#001379); break;
                    case 5: fill(#721405); break;
                    case 6: fill(#317878); break;
                    case 7: fill(#040404); break;
                    case 8: fill(#7b7b7b); break;
                    default: fill(120); break;
                }
                
                // Text displaying number of mines surrounding cell
                if (Minesweeper[i][j] != 0){
                    text(Minesweeper[i][j],gameSize*0.3+(i*gameSize)+gameSize,gameSize*1.75+(j*gameSize));
                }
            }
            // Draws flag
            else if (Minesweeper[i][j] == 10 || Minesweeper[i][j] == 11){
                //Background
                fill(#bdbdbd);
                rect(i*gameSize+gameSize,gameSize*1+(j*gameSize),gameSize,gameSize);
                fill(#ffffff);
                quad(i*gameSize+gameSize,gameSize*1+(j*gameSize),i*gameSize+gameSize*2,gameSize*1+(j*gameSize),i*gameSize+gameSize*1.907,gameSize*1.11+(j*gameSize),i*gameSize+gameSize*1.07,gameSize*1.11+(j*gameSize));
                quad(i*gameSize+gameSize,gameSize*1+(j*gameSize),i*gameSize+gameSize,gameSize*2+(j*gameSize),i*gameSize+gameSize*1.11,gameSize*1.89+(j*gameSize),i*gameSize+gameSize*1.11,gameSize*1.11+(j*gameSize));
                fill(#7b7b7b);
                quad(i*gameSize+gameSize*2,gameSize*1+(j*gameSize),i*gameSize+gameSize*2,gameSize*2+(j*gameSize),i*gameSize+gameSize*1.89,gameSize*1.89+(j*gameSize),i*gameSize+gameSize*1.89,gameSize*1.11+(j*gameSize));
                quad(i*gameSize+gameSize*2,gameSize*2+(j*gameSize),i*gameSize+gameSize,gameSize*2+(j*gameSize),i*gameSize+gameSize*1.11,gameSize*1.89+(j*gameSize),i*gameSize+gameSize*1.89,gameSize*1.89+(j*gameSize));
                
                //Flag platform
                fill(0);
                rect(gameSize*1.28+(i*gameSize),gameSize*1.76+(j*gameSize),gameSize*0.46,gameSize*0.05);
                triangle(gameSize*1.3+(i*gameSize),gameSize*1.76+(j*gameSize),gameSize*1.7+(i*gameSize),gameSize*1.76+(j*gameSize),gameSize*1.5+(i*gameSize),gameSize*1.65+(j*gameSize));
                //Flag pole
                strokeWeight(1.5);
                line(gameSize*1.5+(i*gameSize),gameSize*1.70+(j*gameSize),gameSize*1.5+(i*gameSize),gameSize*1.55+(j*gameSize));
                //Flag
                strokeWeight(0);
                fill(255,0,0);
                triangle(gameSize*1.53+(i*gameSize),gameSize*1.55+(j*gameSize),gameSize*1.53+(i*gameSize),gameSize*1.20+(j*gameSize),gameSize*1.20+(i*gameSize),gameSize*1.375+(j*gameSize));
            }
            // Drawing unopened cells
            else{
                fill(#bdbdbd);
                rect(i*gameSize+gameSize,gameSize*1+(j*gameSize),gameSize,gameSize);
                fill(#ffffff);
                quad(i*gameSize+gameSize,gameSize*1+(j*gameSize),i*gameSize+gameSize*2,gameSize*1+(j*gameSize),i*gameSize+gameSize*1.907,gameSize*1.11+(j*gameSize),i*gameSize+gameSize*1.07,gameSize*1.11+(j*gameSize));
                quad(i*gameSize+gameSize,gameSize*1+(j*gameSize),i*gameSize+gameSize,gameSize*2+(j*gameSize),i*gameSize+gameSize*1.11,gameSize*1.89+(j*gameSize),i*gameSize+gameSize*1.11,gameSize*1.11+(j*gameSize));
                fill(#7b7b7b);
                quad(i*gameSize+gameSize*2,gameSize*1+(j*gameSize),i*gameSize+gameSize*2,gameSize*2+(j*gameSize),i*gameSize+gameSize*1.89,gameSize*1.89+(j*gameSize),i*gameSize+gameSize*1.89,gameSize*1.11+(j*gameSize));
                quad(i*gameSize+gameSize*2,gameSize*2+(j*gameSize),i*gameSize+gameSize,gameSize*2+(j*gameSize),i*gameSize+gameSize*1.11,gameSize*1.89+(j*gameSize),i*gameSize+gameSize*1.89,gameSize*1.89+(j*gameSize));
            }
        }
    }
        // If game is lost
    if (lossX != -1){
        // Display all mines
        for (int i = 0; i < Width; i++){
            for (int j = 0; j < Height; j++){
                if (Minesweeper[i][j] == 9){
                    //Background
                    strokeWeight(1.5);
                    stroke(#727272);
                    fill(#bdbdbd);
                    rect(i*gameSize+gameSize,gameSize+(j*gameSize),gameSize*0.98,gameSize*0.98);
                    //Mine
                    strokeWeight(0);
                    stroke(0);
                    fill(0);
                    ellipse(gameSize*0.5+(i*gameSize)+gameSize,gameSize*1.5+(j*gameSize),gameSize*0.55,gameSize*0.55);
                    strokeWeight(1.6);
                    strokeCap(SQUARE);
                    line(gameSize*1.5+(i*gameSize),gameSize*1.125+(j*gameSize),gameSize*1.5+(i*gameSize),gameSize*1.875+(j*gameSize));
                    line(gameSize*1.125+(i*gameSize),gameSize*1.5+(j*gameSize),gameSize*1.875+(i*gameSize),gameSize*1.5+(j*gameSize));
                    strokeWeight(1.2);
                    line(gameSize*1.24+(i*gameSize),gameSize*1.24+(j*gameSize),gameSize*1.76+(i*gameSize),gameSize*1.76+(j*gameSize));
                    line(gameSize*1.24+(i*gameSize),gameSize*1.76+(j*gameSize),gameSize*1.76+(i*gameSize),gameSize*1.24+(j*gameSize));
                    strokeWeight(0);
                    fill(255);
                    rect(gameSize*0.375+(i*gameSize)+gameSize,gameSize*1.375+(j*gameSize),gameSize*0.11,gameSize*0.11);
                }
            }
        }
        
        // Displays losing move and text
        fill(0);
        textSize(gameSize*0.40);
        text("Press ENTER to try again!",(gameSize*0.67)*Width,gameSize*0.75);
        textSize(gameSize*0.70);
        //Background
        fill(#ed3415);
        strokeWeight(1.5);
        stroke(#727272);
        rect(lossX*gameSize+gameSize,gameSize*1+(lossY*gameSize),gameSize,gameSize);
        //Mine
        strokeWeight(0);
        stroke(0);
        fill(0);
        ellipse(gameSize*0.5+(lossX*gameSize)+gameSize,gameSize*1.5+(lossY*gameSize),gameSize*0.55,gameSize*0.55);
        strokeWeight(1.6);
        strokeCap(SQUARE);
        line(gameSize*1.5+(lossX*gameSize),gameSize*1.125+(lossY*gameSize),gameSize*1.5+(lossX*gameSize),gameSize*1.875+(lossY*gameSize));
        line(gameSize*1.125+(lossX*gameSize),gameSize*1.5+(lossY*gameSize),gameSize*1.875+(lossX*gameSize),gameSize*1.5+(lossY*gameSize));
        strokeWeight(1.2);
        line(gameSize*1.24+(lossX*gameSize),gameSize*1.24+(lossY*gameSize),gameSize*1.76+(lossX*gameSize),gameSize*1.76+(lossY*gameSize));
        line(gameSize*1.24+(lossX*gameSize),gameSize*1.76+(lossY*gameSize),gameSize*1.76+(lossX*gameSize),gameSize*1.24+(lossY*gameSize));
        strokeWeight(0);
        fill(255);
        rect(gameSize*0.375+(lossX*gameSize)+gameSize,gameSize*1.375+(lossY*gameSize),gameSize*0.11,gameSize*0.11);
    }
    
    // Checking if game is won
    if (totalMines == 0){
        // Checks for incorrectly placed flags
        int falseFlags = 0;
        for (int i = 0; i < Width; i++){
            for (int j = 0; j < Height; j++){
                if (Minesweeper[i][j] == 11){
                    falseFlags++;
                }
            }
        }
        
        // If no incorrect flags and no bombs left you win
        if (falseFlags == 0){
            fill(#cf4ac4);
            textSize(gameSize*0.38);
            text("VICTORY! Press ENTER to play again!",(gameSize*0.55)*Width,gameSize*0.75);
            textSize(gameSize*0.70);
            Victory = true;
        }
    }
}
void keyPressed(){
    // When you have lost or won a game, press ENTER to play again
    if (keyCode == ENTER && (lossX != -1 || Victory)){
        totalMines=0;
        setup();
    }
}

void mousePressed(){
    if (lossX == -1 && !Victory){
        // Getting cell mouse is pointing at
        int mx = floor((mouseX-gameSize)/gameSize);
        int my = floor((mouseY-gameSize) / gameSize);
        
        // If it's the first move, creates a safe zone
        if (firstMove && mouseButton == LEFT){
            createSafeZone(mx,my);
            openSpace(mx,my);
            firstMove = false;
        }
        // When cell is clicked, uncovers cell if not a mine. Game lost if cell is a mine
        else if (mouseButton == LEFT){
            if (Minesweeper[mx][my] == 9 || Minesweeper[mx][my] == 10){
                gameLoss(mx,my);
            }
            else{
                openSpace(mx,my);
            }
        }
        // Flagging cells on rigth click
        else if(!firstMove && mouseButton == RIGHT){
            // If flag is put on a mine
            if (Minesweeper[mx][my] == 9){
                Minesweeper[mx][my] = 10;
                totalMines--;
            }
            // If flag is put on cell without mine
            else if (Minesweeper[mx][my] == -1){
                Minesweeper[mx][my] = 11;
                totalMines--;
            }
            // Removing flag from cell with mine, puts mine back into cell
            else if (Minesweeper[mx][my] == 10){
                Minesweeper[mx][my] = 9;
                totalMines++;
            }
            // Removing flag from non mine cell, turns it back into a covered cell
            else if (Minesweeper[mx][my] == 11){
                Minesweeper[mx][my] = -1;
                totalMines++;
            }
        }
    }
}


//Creates safe zone on and around first move
void createSafeZone(int x, int y){
    /* Double for-loop to check surrounding cells for mines by cycling x and y through 0-2 and using x+i-1 and y+j-1, 
    so cells with 1 lower x and/or y value are included and therefore covers all surrounding cells.*/

    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
            // Prevents values outside of the array from being used
            if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= Width || (y+j-1) >= Height){
                continue;
            }
            else{
                // Updates totalMines, if any were removed
                if (Minesweeper[x+i-1][y+j-1] == 9){
                    totalMines--;
                }
                // Sets pressed and surrounding cells to be covered cells
                Minesweeper[x+i-1][y+j-1] = -1;
            }
        }
    }
}

// Function for uncovering cells
void openSpace(int x, int y){
    // If selected cell is a mine, you lose
    if (Minesweeper[x][y] == 9){
        gameLoss(x,y);
    }
    
    // If not a mine, set cell to be number of nearby mines
    Minesweeper[x][y] = countNearbyMines(x,y);
    
    // If a cell is 0, open surrounding spaces and check if any cells surrounding it are also 0 and then repeats with that cell
    if (countNearbyMines(x,y) == 0){
        // Checking surrounding cells
        for (int i = 0; i < 3; i++){
            for (int j = 0; j < 3; j++){
                // Prevents values outside of the array from being used
                if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= Width || (y+j-1) >= Height){
                    continue;
                }
                // If surrounding cell is 0, run function again and set cell to 0
                else if (Minesweeper[x+i-1][y+j-1] == -1 && countNearbyMines(x+i-1,y+j-1) == 0){
                    Minesweeper[x+i-1][y+j-1] = countNearbyMines(x+i-1,y+j-1);
                    openSpace(x+i-1,y+j-1);
                }
                // If surrounding cell has nearby mine(s), set cell to number of surrounding mines 
                else{
                    Minesweeper[x+i-1][y+j-1] = countNearbyMines(x+i-1,y+j-1);
                }
            }
        }
    }
}

// Counts surrounding mines of cell
int countNearbyMines(int x, int y){
    int mineCount = 0;
    for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
             // Prevents values outside of the array from being used
            if ((x+i-1) < 0 || (y+j-1) < 0 || (x+i-1) >= Width || (y+j-1) >= Height){
                continue;
            }
            else{
                if (Minesweeper[x+i-1][y+j-1] == 9 || Minesweeper[x+i-1][y+j-1] == 10){
                    mineCount++;
                }
            }
        }
    }
    return mineCount;
}

// Holds game losing cell
void gameLoss(int x, int y){
    lossX = x;
    lossY = y;
}
