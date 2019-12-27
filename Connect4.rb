class Connect4
    attr_accessor :board, :winner, :boardFull, :gameNum
  
    def initialize
      #Each array will act as a column in a 6 by 7 grid.
      @board = [[],[],[],[],[],[],[]]
      @player1 = Player.new('X')
      @player2 = Player.new('O')
      @winner = false
      @boardFull = false
      @gameNum = 1
    end
  
    def display
      puts " 0 1 2 3 4 5 6 "
      6.times do |x|
        @board.each do |y|
          #Subtract from 5 so that the 'X's and 'O's appear at the bottom of the board   
          if y[5-x].nil?
            print "| "
          else
            print "|#{y[5-x]}"
          end
        end
        print "|"
        puts
      end
      puts "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
    
    end
    
    def getInput(symbol)
      validInput = false
    
      until validInput
        input = -1
    
        until (input >= 0 and input <= 6) do
          puts "Which column do you want to select? Please pick a number between 0 and 6."
          input = gets.chomp.to_i
        end
    
        #Verify column is not full
        if @board[input].length < 6
          @board[input].push(symbol)
          validInput = true
        else
          puts "That column is full! Please try again."
          puts
        end
      end
    end

    def checkBoardFull
      if @board.all? {|x| x.length == 6}
        @boardFull = true
      end
    end
    
    def checkWinner(player)
      #Check columns
      @board.each do |x|
        counter = 0
  
        x.each do |y|
          if y == player.symbol
            counter += 1
          else
            counter = 0
          end
  
          if counter == 4
            @winner = true
            return
          end
        end
      end
  
      #Check rows
      6.times do |x|
        counter = 0
  
        @board.each do |y|
          if y[x] == player.symbol
            counter += 1
          else
            counter = 0
          end
  
          if counter == 4
            @winner = true
            return
          end
        end
      end

      #Check left diagonals
      4.times do |z|
        3.times do |y|
            counter = 0

            4.times do |x|
            if @board[x+z][x+y] == player.symbol
                counter += 1
            else
                break
            end

            if counter == 4
                @winner = true
                return
            end
            end
        end
      end

      #Check right diagonals
      4.times do |z|
        3.times do |y|
          counter = 0

          4.times do |x|
            if @board[x+z][5-(x+y)] == player.symbol
              counter += 1
            else
              break
            end

            if counter == 4
              @winner = true
              return
            end
          end
        end
      end

    end
    
    def play
      #Ensure player1 is first
      player = @player1

      puts
      puts "Game number #{@gameNum}"
      puts
  
      until @winner or @boardFull do
        #Switch players
        if (player == @player1)
          player = @player2
        else
          player = @player1
        end
  
        display()
        puts "It's #{player.name}'s turn"
        getInput(player.symbol)
        checkWinner(player)
        checkBoardFull()
      end
  
      display()
      if @winner
        puts "#{player.name} won!"
        puts

        if player == @player1
          @player1.numOfWins += 1
          @player2.numOfLosses +=1
        else
          @player2.numOfWins += 1
          @player1.numOfLosses +=1
        end
      elsif @boardFull
        puts "Draw!"
        puts

        @player1.numOfDraws += 1
        @player2.numOfDraws += 1
      end
      showStats()
      playAgain?()

    end

    def playAgain?
      validInput = false
      
      until validInput do
        puts "Would you like to play again? (y/n)"
        input = gets.chomp

        if input.downcase == 'yes' || input.downcase == 'y'
          validInput = true
          input = 'y'
        elsif input.downcase == 'no' || input.downcase == 'n'
          validInput = true
          input = 'n'
        end
      end

      if input == 'y'
        @board = [[],[],[],[],[],[],[]]
        @winner = false
        @boardFull = false
        @gameNum += 1
        play()
      else
        exit
      end
    end

    def showStats
      puts "#{@player1.name}'s record ->   Wins: #{@player1.numOfWins}, Losses: #{@player1.numOfLosses}, Draws: #{@player1.numOfDraws}"
      puts
      puts "#{@player2.name}'s record ->   Wins: #{@player2.numOfWins}, Losses: #{@player2.numOfLosses}, Draws: #{@player2.numOfDraws}"
      puts
    end
    
end
  
  class Player
    attr_reader :symbol, :name
    attr_accessor :numOfWins, :numOfLosses, :numOfDraws
  
    def initialize(symbol)
      @symbol = symbol
      @name = getName()
      @numOfWins = 0
      @numOfLosses = 0
      @numOfDraws = 0
    end

    def getName
      puts
      puts "Please enter your first name."
      puts
      input = gets.chomp
      return input
    end
  end

  #uncomment these lines to play
  
  #test = Connect4.new
  #test.play
