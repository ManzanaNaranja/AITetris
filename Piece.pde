public class Piece {
  
  PieceType type;
  PVector[] points;
  PVector position;
  private Piece next;
  PVector reset;
  
  public Piece(PieceType type, int x, int y) {
    this.type = type;
    this.position = new PVector(x, y);
    this.reset = new PVector(x, y);
    this.points = type.points;
    setNext();
  }
  
  public Piece(PieceType type, PVector[] points, int x, int y) {
    this.type = type;
    this.position = new PVector(x, y);
    this.points = points;
  }
  
  void resetPosition() {
    Piece currentPiece = this;
    while(true) {
      currentPiece.position = reset.copy();
      currentPiece = currentPiece.next;
      if(this.equals(currentPiece)) break; // maybe put this in while condition
    }
  }
  
  Piece resetRotation() {
    Piece currentPiece = this;
    while(currentPiece.equals(this.type.getPoints()) == false) {
      currentPiece = currentPiece.next;
    }
    return currentPiece;
  }
 
  public void setNext() {
    Piece currentPiece = this;
    while(true) {
      currentPiece.next = new Piece(this.type, currentPiece.computeNextRotation(), (int) this.position.x, (int)this.position.y);
      currentPiece = currentPiece.next;
      if(this.equals(new Piece(this.type, currentPiece.computeNextRotation(), (int) this.position.x, (int)this.position.y))) {
        currentPiece.next = this;
        break;
      } 
    }
  }
  
  public Piece nextRotation() {
    this.next.position.x = this.position.x;
    this.next.position.y = this.position.y;
    return this.next;
  }
  
   private PVector[] computeNextRotation() {
    int size = Math.max(getWidth(), getHeight());
    int[][] matrix = new int[size][size];
    int[][] inverse = new int[size][size];
    for(int i = 0; i < size; i++) {
      for(int j = 0; j < size; j++) {
        if(i + j == size-1) inverse[i][j] = 1;
      }
    }
    for(PVector p : points) { // input point data
      matrix[(int) p.y][(int) p.x] = 1; 
    }
    matrix = Compute.flipMatrix(matrix);
      
      matrix = Compute.multiplyMatrix(matrix, inverse); // rotates clockwise
      return Compute.matrixToPoints(matrix);
  }
  
  public int getWidth() {
    int leftMost = 999;
    int rightMost = - 100;
    for(PVector p : this.points) {
      if(p.x < leftMost) leftMost = (int)p.x;
      if(p.x > rightMost) rightMost = (int)p.x;
    } 
    return rightMost - leftMost + 1;
  }
  
    public int getHeight() {
    int bottomMost = 999;
    int topMost = -999;
    for(PVector p : this.points) {
      if(p.y < bottomMost) bottomMost = (int)p.y;
      if(p.y > topMost) topMost = (int)p.y;
    } 
    return topMost - bottomMost + 1;
  }
  
  boolean equals(Piece other) {
    for(int i = 0; i < this.points.length; i++) {
       if(arrayContainsAPoint(other.points, this.points[i]) == false) {
         return false;
       }
    }
    return true;
  }
  
  boolean equals(PVector[] pts) { 
    for(int i = 0; i < this.points.length; i++) {
       if(arrayContainsAPoint(pts, this.points[i]) == false) {
         return false;
       }
    }
    return true;
  }
  
  private boolean arrayContainsAPoint(PVector[] arr, PVector point) {
     for(int j = 0; j < arr.length; j++) {
        PVector other = arr[j];
        if(point.x == other.x && point.y == other.y) {
          return true;
        }       
      }
      return false;
  }
  
  public int getGap() {
    // get distance between left most x val and origin (0, 0);
    int minx = 100;
    for(PVector p : this.points) {
      if(p.x < minx) minx = (int)p.x;
    }
    return minx;
  }
  
}
