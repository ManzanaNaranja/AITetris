class Input {

  
  boolean rotate() {
     PVector[] child = fallingPiece.nextRotation().points;
    for(int i = 0; i < child.length; i++) {
      int xPos = (int)(fallingPiece.position.x + child[i].x);
      int yPos = (int)(fallingPiece.position.y + child[i].y);
      
      try {
        if(board.squares[yPos][xPos] != PieceType.Empty) return false;
      } catch(Exception e) {
        return false;
      }
      
      if(xPos < 0 || xPos >= width || yPos < 0 || yPos > height) {
        return false;
      }
    }
    fallingPiece = fallingPiece.nextRotation();
    return true;
      
  }
  
  void drop() {
    fallingPiece.position.y = board.dropHeight(fallingPiece);
    board.place(fallingPiece);
  }
  
  
  boolean moveDown() {
    for(int i = 0; i < fallingPiece.points.length; i++) {
      int xPos = (int)(fallingPiece.position.x + fallingPiece.points[i].x);
      int yPos = (int)(fallingPiece.position.y + fallingPiece.points[i].y);
      if(yPos - 1 < 0 || board.squares[yPos-1][xPos] != PieceType.Empty) {
        board.place(fallingPiece);
        return false;
      } 
    }
    fallingPiece.position.y -= 1;
    return true;
  }
  
  boolean moveRight() {
  for(int i = 0; i < fallingPiece.points.length; i++) {
    int xPos = (int)(fallingPiece.position.x + fallingPiece.points[i].x);
    int yPos = (int)(fallingPiece.position.y + fallingPiece.points[i].y);
    if(yPos > board.height-1 || xPos+1 >= board.width || board.squares[yPos][xPos+1] != PieceType.Empty) {
      return false;
    } 
  }
  fallingPiece.position.x += 1;
  return true;
}
  
  boolean moveLeft() {
    for(int i = 0; i < fallingPiece.points.length; i++) {
      int xPos = (int)(fallingPiece.position.x + fallingPiece.points[i].x);
      int yPos = (int)(fallingPiece.position.y + fallingPiece.points[i].y);
      if(yPos > board.height-1 || xPos == 0 || board.squares[yPos][xPos-1] != PieceType.Empty) {
        return false;
      }     
  }
    fallingPiece.position.x -= 1;
    return true;
}



}
