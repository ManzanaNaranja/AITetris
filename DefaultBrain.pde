public class DefaultBrain implements Brain {
  
  int rowsCleared = 0;
  
  public Brain.Move bestMove(Board board, Piece piece, int limitHeight, Brain.Move move) {
   if(move== null) move = new Brain.Move();
   double bestScore = 1e20;
   int bestX = 0;
   int bestY = 0;
   Piece bestPiece = null;
   Piece current = piece;
   
   board.commit();
   
   while(true) {
     final int yBound = limitHeight - current.getHeight() + 1;
     final int xBound = board.getWidth() - current.getWidth()+1;
     
     int shift = current.getGap();
     
     for(int x = 0; x < xBound; x++) {
       int y = board.dropHeight(current, x-shift);
      // print(y + " ");
       if(y<yBound) {
         board.place(current, x-shift, y);
       //  printBoard();
         rowsCleared = board.clearRows();
         double score = evaluateBoard(board);
         if(score < bestScore) {
           bestScore = score;
           bestX = x-shift;
           bestY = y;
           bestPiece = current;
         }
       }
        board.undo();
      
     }
     // println();
    current = current.nextRotation();
     if(current.equals(piece)) break;
   }
   
   
   if(bestPiece == null) return null;
   else {
     move.x = bestX;
     move.y = bestY;
     move.piece = bestPiece;
     move.score = bestScore;
     return move;
   }
  
  }
  
  void printBoard() {
    for(int y = board.height-1; y >= 0; y--) {
    for(int x = 0; x < board.width; x++) {
        if(board.squares[y][x] == PieceType.Empty) print(0);
        else print(1);
      }
      println();
    }
    println();
     println();
  }
  
  double evaluateBoard(Board board) {
    int holes = getHoles(board);
    int maxHeight = getMaxHeight(board);
    double avgHeight = getAverageHeight(board);
    return 1.25 * holes + 40 * avgHeight + 80 * maxHeight;
   // return maxHeight;
    
    
  //return getHoles(board);
  }
  
  
  int getMaxHeight(Board board) {
    int maxHeight = -1;
    int[] heights = board.heights(board.height-1);
    for(int i = 0; i < heights.length; i++) {
        if(heights[i] > maxHeight) {
          maxHeight = heights[i];
        }
    }
    return maxHeight;
  }
  
  double getAverageHeight(Board board) {
    double sum = 0;
    int[] heights = board.heights(board.height-1);
    for(int i = 0; i < heights.length; i++) {
      sum += heights[i];
    } 
    double avg = sum / heights.length;
    return avg;
    
  }
  
  int getHoles(Board board) {
    int holes = 0;
    int[] heights = board.heights(board.height-1);
    
    for(int x = 0; x < board.width; x++) {
      for(int y = 0; y < heights[x]; y++) {
        if(board.squares[y][x] == PieceType.Empty) {
          holes++;
        }
      }
    }
    return holes;
 
  }

}
