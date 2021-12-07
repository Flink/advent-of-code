input = File.readlines("input.txt", chomp: true).map { _1.split("") }
bits = input.transpose.map { _1.tally.invert }

def find_number(set, bit_criteria, step = 0)
  bit = set.transpose.map { |b| b.tally.tap { _1["1"] += 1 unless _1.one? }.invert.public_send(bit_criteria.zero? ? :min : :max) }[step][1]
  set = set.select { _1[step] == bit }
  return set if set.one?
  find_number(set, bit_criteria, step + 1)
end

puts %i[min max].map { |sym| bits.map { _1.public_send(sym).last }.join.to_i(2) }.reduce(:*)
puts [0, 1].map { find_number(input, _1).join.to_i(2) }.reduce(:*)
