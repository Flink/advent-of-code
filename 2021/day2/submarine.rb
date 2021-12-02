class Submarine
  attr_reader :depth, :position, :aim

  def initialize
    @depth = @position = @aim = 0
  end

  def forward(units)
    @position += units
    @depth += aim * units
  end

  def down(units)
    @aim += units
  end

  def up(units)
    @aim -= units
  end

  def final_positions
    [aim * position, depth * position]
  end
end

Submarine.new.tap do |submarine|
  File.foreach("input") do |line|
    command, units = line.split(" ")
    submarine.public_send(command, units.to_i)
  end
  puts submarine.final_positions
end
