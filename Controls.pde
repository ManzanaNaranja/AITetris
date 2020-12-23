

public void keyPressed() {
  
   if(key == '0') {
    setup();
  }
  
  
 if(board.isGameOver() == false) {
  if(key == ' ') {
    input.drop();
    newCycle();
  }
  
  if(key == 's') {
    if(false == input.moveDown()) {
      newCycle();
    }
  }
  
  if(key == 'd') {
    input.moveRight();
  }
  
  if(key == 'a') {
    input.moveLeft();
  }
  
  if(key == 'w') {
    input.rotate();
  }
  
  if(key == 'o') {
    BigBrain b = new BigBrain();
    Brain.Move move = b.bestMove(board, fallingPiece, 23, new Brain.Move());
    println(move.x + " " + move.y);
    
    board.place(move.piece, move.x, move.y);
    newCycle();
  }
  
 
  
  
  
  

  
  board.show(fallingPiece);
  
 }
}
