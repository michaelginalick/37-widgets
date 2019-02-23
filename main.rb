require_relative 'sensor_evaluation'

#driver code
if ARGV.length != 1
  puts "Please provide a log file to analyze."
  exit;
end

filename = ARGV[0]
begin
  puts "Going to analyze #{filename}"
  file = File.open(filename)
  x = SensorEvaluation.new(file)
  puts x.calculate_percision
rescue StandardError => error
  puts "A problem occured #{error.backtrace}"
ensure
  file.close
end
