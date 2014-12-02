module TicTacToe
  class GameBoard
    attr_accessor :board
    def initialize
      @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @run = true
    end
    

    def show_board
      i = 0
      3.times do
    	  puts @board[i].to_s + " " + @board[i+1].to_s + " " + @board[i+2].to_s
        i += 3
      end
      return " "
    end

    def turn_x
    	show_board
    	puts "Please enter a valid spot (1-9) to place your X."
    	choice = gets.chomp.to_i
      if @board.include? (choice)
        @board.map! do |element|
        	if element == choice
        		element = "X"
        	else
        		element
        	end
        end
      else
      	puts "Wrong choice!"
      	turn_x
      end
    end

    def turn_o
    	show_board
    	puts "Please enter a valid spot (1-9) to place your O."
    	choice = gets.chomp.to_i
    	if @board.include? (choice)
    	  @board.map! do |element|
    		if element == choice
    		  element = "O"
    		else
    			element
    		end
    	  end
    	else
    		puts "Wrong choice!"
    		turn_o
    	end
    end

    def winner
    	result = false
      i = 0
      j = 0
    	3.times do #checking for horizontal match
    	  if @board[i] == @board[i+1] && @board[i] == @board[i+2]
    	  	result = true
    	  end
    	  i += 3
    	end
      3.times do #checking for vertical match
        if @board[j] == @board[j+3] && @board[j] == @board[j+6]
          result = true
        end
        
        j += 1
      end
      #checking for diagonal matches
      if @board[0] == @board[4] && @board[0] == @board[8]
        result = true
      elsif @board[6] == @board[4] && @board[6] == @board[2]
        result = true
      end
    	result
    end

    def tie
      board.all? { |matrix| matrix.is_a? String}
    end


  def game_result
    if winner
      show_board
      puts "Game Over!"
      @run = false
    elsif tie
      show_board
      puts "Tie!"
      @run = false
    end
  end

    def run_game
    	while @run
    		turn_x
        game_result
        break unless @run == true
    		turn_o
        game_result
      end

    end

    def take_diagonal
      if @board[0].is_a? Fixnum
        @board[0] = "O"
        turn_over = true
      elsif @board[2].is_a? Fixnum
        @board[2] = "O"
        turn_over = true
      elsif @board[6].is_a? Fixnum
        @board[6] = "O"
        turn_over = true
      elsif @board[8].is_a? Fixnum
        @board[8] = "O"
        turn_over = true
      end
      turn_over
    end

    def take_side
      if @board[1].is_a? Fixnum
        @board[1] = "O"
        turn_over = true
      elsif @board[7].is_a? Fixnum
        @board[7] = "O"
        turn_over = true
      elsif @board[3].is_a? Fixnum
        @board[3] = "O"
        turn_over = true
      elsif @board[5].is_a? Fixnum
        @board[5] = "O"
        turn_over = true    
      end
      turn_over
    end


    def artificial
      #if choice results in win for O, do that.
      turn_over = false
      i = 0
      while i < 9
        original_element = @board[i]
        @board[i] = "O" unless @board[i] == "X"
        if winner
          turn_over = true
          i = 9
        else
          @board[i] = original_element
          i += 1
        end
      end
   
      # elseif choice blocks a win for X, do that.
      unless turn_over
        i = 0
        while i < 9
          original_element = @board[i]
          @board[i] = "X" unless @board[i] == "O"
          puts original_element
          if winner
            turn_over = true
            @board[i] = "O"  
            i = 9
          else      
            @board[i] = original_element
            i += 1
          end
        end

      end

      unless turn_over
        unless @board[4].is_a? String
          @board[4] = "O"
          turn_over = true
        end
      end

      unless turn_over
        if @board[4] == "O"
          take_side || take_diagonal
        else  
          take_diagonal || take_side
        end       
      end
    end

        

    def ai_game
      while @run
        turn_x
        game_result
        break unless @run == true
        artificial
        game_result
      end
    end

  end
end

include TicTacToe
playing = true
while playing
  round = GameBoard.new
  puts "Welcome to tic-tac-toe! Input A to play with the AI, or anything else to play two-player."
  game_type = gets.chomp.upcase
  if game_type == "A"
    round.ai_game
  else
    round.run_game
  end
  puts "Enter N to exit; enter anything else to play again."
  replay = gets.chomp.upcase
  if replay == "N"
    playing = false
  end
end
