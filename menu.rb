puts '[FarmBot Controller Menu]'
puts 'starting up'

require './lib/database/dbaccess.rb'
require './lib/database/filehandler.rb'

#require './lib/controller.rb'
#require "./lib/hardware/ramps.rb"

#$bot_control    = Control.new
#$bot_hardware     = HardwareInterface.new

$shutdown    = 0

# just a little menu for testing

puts 'connecting to database'

$bot_dbaccess = DbAccess.new

$move_size = 10
$command_delay = 0

while $shutdown == 0 do

  system('cls')
  system('clear')

  puts '[FarmBot Controller Menu]'
  puts ''
  puts 'p - stop'
  puts 't - execute test file'
  puts ''
  puts "move size = #{$move_size}"
  puts "command delay = #{$command_delay}"
  puts ''
  puts 'w - forward'
  puts 's - back'
  puts 'a - left'
  puts 'd - right'
  puts 'r - up'
  puts 'f - down'
  puts ''
  puts 'z - home z axis'
  puts 'x - home x axis'
  puts 'c - home y axis'
  puts ''
  puts 'q - step size'
  puts 'g - delay seconds'
  puts ''
  print 'command > '
  input = gets
  puts ''

  case input.upcase[0]
    when "P" # Quit
      $shutdown = 1
      puts 'Shutting down...'
    when "O" # Get status
      puts 'Not implemented yet. Press \'Enter\' key to continue.'
      gets
    when "Q" # Set step size
      print 'Enter new step size > '
      move_size_temp = gets
      $move_size = move_size_temp.to_i if move_size_temp.to_i > 0
    when "G" # Set step delay (seconds)
      print 'Enter new delay in seconds > '
      command_delay_temp = gets
      $command_delay = command_delay_temp.to_i if command_delay_temp.to_i > 0
    when "T" # Execute test file
      # read the file
      TestFileHandler.readCommandFile
    when "Z" # Move to home
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('HOME Z', 0, 0, 0, 0, 0)
      $bot_dbaccess.save_new_command
    when "X" # Move to home
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('HOME X', 0, 0, 0, 0, 0)
      $bot_dbaccess.save_new_command
    when "C" # Move to home
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('HOME Y',0 ,0 ,-$move_size, 0, 0)
      $bot_dbaccess.save_new_command
    when "W" # Move forward
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('MOVE RELATIVE',0,$move_size, 0, 0, 0)
      $bot_dbaccess.save_new_command
    when "S" # Move back
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('MOVE RELATIVE',0,-$move_size, 0, 0, 0)
      $bot_dbaccess.save_new_command
    when "A" # Move left
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('MOVE RELATIVE', -$move_size, 0, 0, 0, 0)
      $bot_dbaccess.save_new_command
    when "D" # Move right
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('MOVE RELATIVE', $move_size, 0, 0, 0, 0)
      $bot_dbaccess.save_new_command
    when "R" # Move up
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line('MOVE RELATIVE', 0, 0, $move_size, 0, 0)
      $bot_dbaccess.save_new_command
    when "F" # Move down
      $bot_dbaccess.create_new_command(Time.now + $command_delay)
      $bot_dbaccess.add_command_line("MOVE RELATIVE", 0, 0, -$move_size, 0, 0)
      $bot_dbaccess.save_new_command
    end

end


