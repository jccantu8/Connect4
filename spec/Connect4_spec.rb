require './Connect4'

describe Connect4 do
  before(:all) { @test = Connect4.new
            @testPlayer = Player.new('X')}

  describe '#checkBoardFull' do
    it 'returns true if board is full' do
      @test.board = [['X','X','X','X','X','X'],['X','X','X','X','X','X'],['X','X','X','X','X','X'],['X','X','X','X','X','X'],['X','X','X','X','X','X'],['X','X','X','X','X','X']]
      @test.checkBoardFull
      expect(@test.boardFull).to be_truthy
    end
  end

  describe '#checkWinner' do
    it 'return true if board has a winner in the vertical' do
      @test.board = [['X','X','X','X'],['O','O','O'],[],[],[],[],[]]
      @test.checkWinner(@testPlayer)
      expect(@test.winner).to be_truthy
    end

    it 'return true if board has a winner in the diagonal' do
      @test.board = [['X'],['O','X'],['O','O','X'],['O','O','O','X'],[],[],[]]
      @test.checkWinner(@testPlayer)
      expect(@test.winner).to be_truthy
    end
    
    it 'return true if board has a winner in the diagonal' do
      @test.board = [[],[],[],['O','O','O','X'],['O','O','X'],['O','X'],['X']]
      @test.checkWinner(@testPlayer)
      expect(@test.winner).to be_truthy
    end

    it 'return true if board has a winner in the horizontal' do
      @test.board = [['X'],['X'],['X'],['X'],[],[],['O','O','O']]
      @test.checkWinner(@testPlayer)
      expect(@test.winner).to be_truthy
    end
  end

end