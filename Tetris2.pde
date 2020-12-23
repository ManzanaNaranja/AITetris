  Board board;
  Piece fallingPiece;
  Input input;
  
  Piece[] pieces;

  void setup() {
  size(600, 600);
  background(#F0F0F0);
  
  board = new Board(25, 10, 24);
  input = new Input();
  initPieces();
  
  fallingPiece = getRandomPiece();
  

  board.show(fallingPiece);
  
  
  }

  
  
  void draw() {
    
    if(frameCount % 20 == 0 && board.isGameOver() == false) {
        background(#F0F0F0);
        fill(0);
        if(false == input.moveDown()) {
          newCycle();
        }
        board.show(fallingPiece);
    }
    
    
  }
  
  void newCycle() {
    fallingPiece = getRandomPiece();
    fallingPiece.resetPosition();
    fallingPiece = fallingPiece.resetRotation();
    board.clearRows();
  }
  
  void initPieces() {
    pieces = new Piece[PieceType.values().length-1];
    for(int i = 0; i < PieceType.values().length-1; i++) {
      pieces[i] = new Piece(PieceType.values()[i], 4,20);
    }
  }
  
  Piece getRandomPiece() {
    int randIndex = (int)(Math.random() * pieces.length);
    return pieces[randIndex];
  }

  
