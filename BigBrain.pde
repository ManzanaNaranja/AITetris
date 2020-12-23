class BigBrain extends DefaultBrain{

  double evaluateBoard(Board board) {
    
    double rowsCleared = completeLines();
    double weightedHeight = getMaxHeight(board);
    double cumulativeHeight = aggregateHeight(board);
    double relativeHeight = relativeHeight(board);
    double holes = getHoles(board);
    double roughness = bumpiness(board);
    
    return -0.225686496 * rowsCleared + 0.08679520 * weightedHeight + 0.61527277 * cumulativeHeight + 0.140349898 * relativeHeight + 0.03808642 * holes + 0.0215861095 * roughness;
    
    
    
    

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
  
  double relativeHeight(Board board) {
    int lowest = 999;
    int biggest = -1;
    for(int i : board.heights()) {
      if(i < lowest) lowest = i;
      if(i > biggest) biggest = i;
    }
    return biggest - lowest;
  }
  

}
