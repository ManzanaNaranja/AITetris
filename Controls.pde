

public void keyPressed() {
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
    DefaultBrain b = new DefaultBrain();
    Brain.Move move = b.bestMove(board, fallingPiece, 23, new Brain.Move());
    print(move.x + " " + move.y);
    
    board.place(move.piece, move.x, move.y);
    newCycle();
  }
  
  

  
  board.show(fallingPiece);
  
 }
}
