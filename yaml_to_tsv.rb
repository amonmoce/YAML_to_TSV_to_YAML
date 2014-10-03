# Check the output file
if ARGV[1].nil?
  print 'Insert the name of your output file (tsv file) '
  outname = $stdin.gets.chomp
else
  outname = ARGV[1]
end

# Deserialize
require 'yaml'
survey = YAML.load(File.read(ARGV[0]))

# Create the TSV file
first_hash = survey[0]
keys_array = first_hash.keys
line = ''
keys_array.each { |key| line.concat(key + "\t") }

File.open(outname, 'w') do |file|
  file.puts line
  survey.each do |record|
    record.each_value { |value| file << value + "\t" }
    file << "\n"
  end
end
