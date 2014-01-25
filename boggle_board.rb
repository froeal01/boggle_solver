# You should re-use and modify your old BoggleBoard class
# to support the new requirements
require 'debugger'


class BoggleBoard
  attr_accessor :board

  def initialize
    @board = []
    @dies = %w(AAEEGN
      ELRTTY
      AOOTTW
      ABBJOO
      EHRTVW
      CIMOTU
      DISTTY
      EIOSST
      DELRVY
      ACHOPS
      HIMNQU
      EEINSU
      EEGHNW
      AFFKPS
      HLNNRZ
      DEILRX
      )
end

def shake!

  temp = @dies.shuffle.map { |i| "" + i[rand(5)] + ""}
  @board = Array.new(4) { temp.shift(4) }
  @board.each_with_index do | array, row|
    array.each_with_index do |letter, column|
      @board[row][column] = " Qu" if letter == ' Q '
    end
  end
end

def to_s
  puts ("-"*25).to_s.center(50)
  @board.each do |row|

    puts ("| " + row.join(" | ") + " |").center(50)
  end
  puts ("-"*25).to_s.center(50)
end


def find_adjacents(row_index, column_index)
  adjacent_chars = []
  available_indexes = (0..3).to_a
  
  -1.upto(1) do |row_increment|
    -1.upto(1) do |column_increment|
      row_lookup_index = row_index+row_increment
      column_lookup_index = column_index+column_increment
      
      if available_indexes.include?(row_lookup_index) and  available_indexes.include?(column_lookup_index) and !(row_increment==0 && column_increment==0)
        adjacent_chars << @board[row_lookup_index][column_lookup_index]
      end
    
    end
  end
  
  return adjacent_chars
end


def all_adjacents(char)
  all_adjacents = []
  
  @board.each_with_index do | row, r_index|
    row.each_with_index do |letter, c_index|
      
      all_adjacents << find_adjacents(r_index,c_index) if letter == char

     end
   end
   
   all_adjacents
end

def print_board(word)
  system("clear")
  puts self.to_s
  p word
  sleep(0.3)
end

def search?(word)

  return true if word.length == 1 and @board.flatten.include?(word) 

  char = word[0]
  
  print_board(word)

  all_adjacents(char).each do |adjacents|
    if adjacents.include?(word[1])
      return true if search?(word[1..-1])
    end
  end

  false
   
end


end
               
board=BoggleBoard.new

# board.shake!

board.board = [["W","O","R","D"],["A","L","E","X"],["C","A","R","S"],["D","B","C","A"]]
p board
# p board.find_adjacents(0,2)
# p board.all_adjacents("E")
 p board.search?("WORDXELACARSACBD")

# p ledger
# # p adjacent?([2, 0],[2,3])

# word = word_split("HOO")
# p word

# if search?(word, ledger) == true
#   puts "yousucknot"
# else
#   puts "well..."
# end




























