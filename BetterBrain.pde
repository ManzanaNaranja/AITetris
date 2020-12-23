class BetterBrain extends DefaultBrain{

  double evaluateBoard(Board board) {
    int holes = getHoles(board);
    double aggregateHeight = aggregateHeight(board);
    double bumpy = bumpiness(board);
    double completeLines = completeLines();
    
    return .510066 * aggregateHeight + -.760666 * completeLines + .35663 * holes + .184483 * bumpy;
   // return maxHeight;
    
    
  //return getHoles(board);
  }
  
  double aggregateHeight(Board board) {
    return (int) (getAverageHeight(board) * 10);
  }
  
  double completeLines() {
    return rowsCleared;
  }
  
  double bumpiness(Board board) {
    int heights[] = board.heights();
    int sum = 0;
    for(int i = 1; i < 9; i++) {
      sum += Math.abs(heights[i] - heights[i-1]);
      sum += Math.abs(heights[i] - heights[i+1]);
    }
    return sum;
  }

}
