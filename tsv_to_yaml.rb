# Check the output file
if ARGV[1].nil?
  print 'Insert the name of your output file (yml file) '
  outname = $stdin.gets.chomp
else
  outname = ARGV[1]
end

# Build the array of Hashes
require 'yaml'

survey = []
lines = []
tsv_file = File.open(ARGV[0], 'r')
tsv_file.each_line { |line| lines << line }
tsv_file.close
keys = lines[0].split("\t")
keys.map!(&:chomp)

lines.shift
lines.each do |line|
  values = line.split("\t")
  record = Hash.new
  keys.each_index { |index| record[keys[index]] = values[index].chomp }
  survey.push(record)
end

# Serialize the data
File.open(outname, 'w') do |file|
  file.puts survey.to_yaml
end
