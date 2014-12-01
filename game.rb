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
  	3.times do
  	  if @board[i] == @board[i+1] && @board[i] == @board[i+2]
  	  	result = true
  	  end
  	  i += 3
  	end
  	result
  end




  def run_game
  	while @run
  		turn_x
  		turn_o
  		if winner
  		  show_board
  		  puts "Game Over!"
  		  @run = false
  		end
  	end
  end

end