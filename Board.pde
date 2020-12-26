class Board {

  int size;
  int height;
  int width;
  
  int xShift, yShift;
  
  int score = 0;
  
  PieceType[][] squares;
  PieceType[][] backup;
  PieceType[][] backup2;
  
  boolean gameOver = false;
  
  Board(int size, int width, int height) {
    this.size = size;
    this.height = height;
    this.width = width;
    
    this.xShift = (int)(300 - this.width*size*.5);
    this.yShift = (int)(250 + this.height*size*.5);
    
    this.squares = new PieceType[height][width];
    this.backup = new PieceType[height][width];
    this.backup2 = new PieceType[height][width];
    initArray(squares);
    initArray(backup);
    initArray(backup2);
    

  }
  
  void commit2() {
    for(int y = 0; y < this.height; y++) {
      for(int x = 0; x < this.width; x++) {
        backup2[y][x] = squares[y][x];
      }
    }
  }

  void undo2() {
    for(int y = 0; y < this.height; y++) {
      for(int x = 0; x < this.width; x++) {
        squares[y][x] = backup2[y][x];
      }
    }
  }
  
  void commit() {
    for(int y = 0; y < this.height; y++) {
      for(int x = 0; x < this.width; x++) {
        backup[y][x] = squares[y][x];
      }
    }
  }
  
  void undo() {
    for(int y = 0; y < this.height; y++) {
      for(int x = 0; x < this.width; x++) {
        squares[y][x] = backup[y][x];
      }
    }
  }
  
  public int getWidth() { return this.width; }
  public int getHeight() { return this.height; }
  
  private void initArray(PieceType[][] arr) {
    for(int i = 0; i < height; i++) {
       for(int j = 0; j < width; j++) {
          arr[i][j] = PieceType.Empty;
      }
    }
  }
  
  boolean isGameOver() {
    if(this.gameOver == true) return true;
    if(widths()[height-4] != 0) {
      return true;
    }
    return false;
  }
  
  void place(Piece piece) {
    this.place(piece, (int)piece.position.x, (int)piece.position.y);
  }
  
  void place(Piece piece, int x, int y) {
    
    for(int i = 0; i < piece.points.length; i++) {
      int xPos = (int)(x + piece.points[i].x);
      int yPos = (int)(y + piece.points[i].y);
      this.squares[yPos][xPos] = piece.type;

    }
  }
  
  int clearRows() {
    int count = 0;
   int[] widths = this.widths();
   
   for(int i = 0; i < height; i++) {
     if(widths[i] == width) {
       count+=1;
       
       clearLine(i);
       slideBlocksDown(i);
       widths = this.widths(); // recompute after shift
       i--;// loop through this thing again incase anything fell down.
     }
   }
   return count;
 }
 
  
 private void slideBlocksDown(int row) { // row to shift to
    for(int y = row+1; y < height; y++) {
      for(int x = 0; x < width; x++) {
        squares[y-1][x] = squares[y][x];
      }
    }
  }
  
   private void clearLine(int row) {
    for(int i = 0; i < squares[0].length; i++) {
      this.squares[row][i] = PieceType.Empty;
    }
  }
  

  
  int[] widths() {
    int[] widths = new int[height];
    for(int y = 0; y < height; y++) {
      widths[y] = getWidthOfRow(y);
    }
    return widths;
}
  
  int getWidthOfRow(int y) {
    int w = 0;
     for(int x = 0; x < width; x++) {
        if(this.squares[y][x] != PieceType.Empty) {
          w+=1;
        }
      }
      return w;
  }
  
  int[] heights() {
    return heights(this.height-1);
  }
  
  int[] heights(int maxHeight) {
    int[] heights = new int[width];
    for(int x = 0; x < width; x++) {
      heights[x] = getHeightOfColumn(x, maxHeight);
    }
    return heights;
  }
  
  int getHeightOfColumn(int x, int maxHeight) {
    int height = 0;
        for(int y = maxHeight; y >= 0; y--) { 
           if(squares[y][x] != PieceType.Empty) {
           height = y+1;
           break;
        }
    }
    return height;
}

  int dropHeight(Piece piece) {
    return dropHeight(piece, (int)piece.position.x);
 }
 
 int dropHeight(Piece piece, int x) {
   int prevPos = (int)piece.position.x;
   piece.position.x = x;
   
   int smallestHeight = 10000;
   int yIndex = -1; // we need shift of piece position
   int diff = -1; // difference between origin position and yposotion of actuail point of piece
   
   
   for(int i = 0; i < piece.points.length; i++) {
      int xPos = (int)(piece.position.x + piece.points[i].x);
      int yPos = (int)(100 + piece.points[i].y); // DROPPED FROM INFINITELY HIGH
      int height = (int)(yPos - heights()[xPos]);
      if(height < smallestHeight) {
        smallestHeight = height;
        yIndex = heights()[xPos];
        diff = (int) piece.points[i].y; // ypos - 0 = ypos
      }
   }
   piece.position.x = prevPos;
   return yIndex - diff;
 }
 
 void show(Piece piece, Piece nextPiece) {
   background(#F0F0F0);
   drawPieces();
   drawFallingPiece(piece);
 //  drawNextFallingPiece(nextPiece);
   drawScore();
   drawBorder();
   
 }
 
 void drawScore() {
     push();
     fill(0);
     text("score: " + board.score, 240, 65);
     pop();
 }
 
 void drawNextFallingPiece(Piece piece) {
   int gridSize = 25;

   
   push();
   noStroke();
   
   
   for(int i = 0; i < piece.points.length; i++) {
     fill(piece.type.getColor());
     rect(xShift + size * width+30+piece.points[i].x*gridSize+10, 75+120-piece.points[i].y*gridSize-gridSize-30, gridSize, gridSize);
   }
   pop();
  drawNextFallingPieceBorder();

 }
 
 void drawNextFallingPieceBorder() {
   push();
   stroke(0);
   noFill();
   strokeWeight(3);
   rect(xShift + size * width+30, 75, 120, 120);
   pop();
 }
 
 void drawFallingPiece(Piece piece) {
   push();
   noStroke();
   fill(piece.type.getColor());
   for(int i = 0; i < piece.points.length; i++) {
      int xPos = (int)(piece.position.x + piece.points[i].x);
      int yPos = (int)(piece.position.y + piece.points[i].y);
      if(yPos < height-4) {
        rect(xShift + xPos*size, yShift + (height-1 * size) - yPos*size, size, size);
      }
   }
   pop();
 }
 
 void drawPieces() {
     for (int y = 0; y < height-4; y++) { // only to go height-2 so don't draw top two board spaces (reserved for fallign effect)
      for (int x = 0; x < width; x++) {
        push();
        noStroke();
        fill(squares[y][x].getColor());
        rect(xShift + x*size, yShift + (height-1 * size) - y*size, size, size);
        pop();  
      }
    }
 }
 
 
 void drawBorder() {
   noFill();
   strokeWeight(3);
   rect(xShift, 75, this.width*this.size, this.height*this.size-4*size);
 }
 
 
  
  




}
