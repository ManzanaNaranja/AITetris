static class Compute {
  
  static int[][] multiplyMatrix(int[][] m1, int[][] m2) {
    int r1 = m1.length;
    int c1 = m1[0].length;
    
    //int r2 = m2.length;
    int c2 = m2[0].length;
    
    
    
    
    int[][] product = new int[r1][c2];
    for(int i = 0; i < r1; i++) {
      for(int j = 0; j < c2; j++) {
        for(int k = 0; k < c1; k++) {
          product[i][j] += m1[i][k] * m2[k][j];
        }
      }
    }
    return product;
  }
  
    static PVector[] matrixToPoints(int[][] matrix) {
    PVector[] points = new PVector[4];
    int count = 0;
    for(int i = 0; i < matrix.length; i++) {
      for(int j = 0; j < matrix.length; j++) {
        if(matrix[i][j] == 1) {
          points[count] = new PVector(j, i);
          count++;
        }
      }
    }
    return points;
  }
  
  static int[][] flipMatrix(int[][] matrix) { 

    for(int i = 0; i < matrix.length; i++) {
      for(int j = 0; j < matrix.length; j++) {
        if(j > i) {
          int temp = matrix[i][j];
          matrix[i][j] = matrix[j][i];
          matrix[j][i] = temp;    
        }
      }
    }
    return matrix;
  }

}
