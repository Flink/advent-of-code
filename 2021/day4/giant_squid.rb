targets = []
boards = []
board_scores = []
winner_boards = {}
game_state = Hash.new { _1[_2] = {marked: false, boards: [], number: _2} }

File.foreach("input", chomp: true).with_index do |line, i|
  next targets = line.split(",") if i.zero?
  next boards << [] if line.empty?

  current_board = boards.last
  current_board << line.strip.split(/\s+/).map { game_state[_1].tap { |gs| gs[:boards] << current_board } }
end

targets.each_with_index do |number, i|
  game_state[number][:marked] = true
  next if i < 5

  game_state[number][:boards].each do |board|
    next if winner_boards[board]
    next unless [board, board.transpose].any? { |b| b.detect { |r| r.count { _1[:marked] } == 5 } }

    board_scores << board.flatten.select{ !_1[:marked] }.sum { _1[:number].to_i } * number.to_i
    winner_boards[board] = true
  end
end

puts board_scores.first
puts board_scores.last
