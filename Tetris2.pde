  Board board;
  Piece fallingPiece;
  Piece nextFallingPiece;
  Input input;
  DefaultBrain brain;
  Brain.Move move;

  
  
  Piece[] pieces;

  void setup() {
  size(600, 600);
  background(#F0F0F0);
  
  board = new Board(25, 10, 24);
  input = new Input();
  brain = new DefaultBrain();
  

  
  initPieces();
  
  fill(0);
  textSize(36);
   text("score: " + board.score, 240, 65);
  
  fallingPiece = getRandomPiece();
  nextFallingPiece = getRandomPiece();
  

  board.show(fallingPiece, nextFallingPiece);
  
  move = brain.bestMove(board, fallingPiece, 20, new Brain.Move());
  
  
  }


  
  void draw() {
    
    if(frameCount % 3 == 0 && board.isGameOver() == false) {
        
        if(fallingPiece.position.y < 20 && move != null) {
            
            if(fallingPiece.position.x < move.x) input.moveRight();
            else if(fallingPiece.position.x > move.x) input.moveLeft();
            else if(fallingPiece.position.x == move.x && fallingPiece.equals(move.piece)) input.drop();
            
            if(fallingPiece.equals(move.piece) == false) input.rotate();
        }    

       
      
        
        if(false == input.moveDown()) {
          newCycle();
        }
        board.show(fallingPiece, nextFallingPiece);
    }
    
   
    
    
  }
  
  void newCycle() {
    fallingPiece = nextFallingPiece;
    nextFallingPiece = getRandomPiece();
    fallingPiece.resetPosition();
    fallingPiece = fallingPiece.resetRotation();
    board.score += board.clearRows();
    
    move = brain.bestMove(board, fallingPiece, 20, new Brain.Move());
    

    
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

  
