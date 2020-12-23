  Board board;
  Piece fallingPiece;
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
  

  board.show(fallingPiece);
  
  move = brain.bestMove(board, fallingPiece, 23, new Brain.Move());
  
  
  }


  
  void draw() {
    
    if(frameCount % 20 == 0 && board.isGameOver() == false) {
        
        if(fallingPiece.position.y < 20) {
            
            if(fallingPiece.position.x < move.x) input.moveRight();
            if(fallingPiece.position.x > move.x) input.moveLeft();
            
            if(fallingPiece.equals(move.piece) == false) input.rotate();
        }    

       
        background(#F0F0F0);
        fill(0);
        text("score: " + board.score, 240, 65);
        
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
    board.score += board.clearRows();
    
    move = brain.bestMove(board, fallingPiece, 23, new Brain.Move());
    

    
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

  
