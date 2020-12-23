public interface Brain {
  public static class Move {
    public int x, y;
    public Piece piece;
    public double score;
  }
  
  public Brain.Move bestMove(Board board, Piece piece, int limitHeight, Brain.Move move);
}
