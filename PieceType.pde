
import static java.lang.Math.*;
public enum PieceType {
  
  O(new PVector[] {new PVector(0,0), new PVector(0,1), new PVector(1, 0), new PVector(1, 1)}, #E39F02),
  I(new PVector[] {new PVector(0, 1), new PVector(1, 1), new PVector(2, 1), new PVector(3, 1)}, #0F9BD7),
  L(new PVector[] {new PVector(0, 0), new PVector(0, 1), new PVector(1, 0), new PVector(2, 0)}, #E35B02),
  T(new PVector[] {new PVector(1, 0), new PVector(0, 1), new PVector(1, 1), new PVector(2, 1)}, #AF298A),
  S(new PVector[] {new PVector(0, 0), new PVector(1, 0), new PVector(1, 1), new PVector(2, 1)}, #D70F37),
  Z(new PVector[] {new PVector(1, 0), new PVector(1, 1), new PVector(0, 1), new PVector(2, 0)}, #59B101),
  J(new PVector[] {new PVector(0, 0), new PVector(1, 0), new PVector(2, 0), new PVector(2, 1)}, #2141C6),
  L2(new PVector[] {new PVector(0, 1), new PVector(1, 0), new PVector(0, 0), new PVector(2, 0)}, #E35B02),
  Empty(#FFFFFF);
  
  private final PVector[] points;
  private final color col;
  
  private PieceType(color col) {
    this.col = col;
    this.points = null;
  }
  
  private PieceType(PVector[] points, color col) {
    this.points = points;
    this.col = col;
  }
  
  public PVector[] getPoints() {
    return this.points;
  }
  
  public color getColor() {
    return this.col;
  }
    
  //public static PieceType getRandomPieceType() {
  //  int randomIndex = (int)(Math.random() * PieceType.values().length-1);
  //  return PieceType.values()[randomIndex];
  //}





}
