#!/usr/bin/env ruby

require 'json'

data = {}
aliases = {}

# replace *.rb with ruby etc.
def sub_scripts(command)
  if command && command.start_with?('./')
    ext = command[/.+\.([A-Za-z]+)$/,1]
    case ext
    when 'rb'
      'ruby'
    when 'py'
      'python'
    when 'sh'
      'bash'
    when 'r'
      'Rscript'
    else
      ext
    end
  else
    command
  end
end

# load bash aliases for substitution
File.readlines('/home/caleb/.bash_aliases').each do |line|
  # TODO: might be nil if no match found, log this line
  ali, command = line.match(/alias ([A-Za-z0-9]{1,})='([A-Za-z0-9\/]{1,})[\s']/i).captures
  aliases[ali] = command
end

Dir.glob('data/*').each do |file|
  File.readlines(file).each do |line|
    command = line.strip.split(/[\s;]/)[0]

    # Substitute Aliases
    command = aliases[command] unless aliases[command].nil?
    command = sub_scripts(command)

    if data[command].nil?
      data[command] = 1
    else
      data[command] += 1
    end
  end
end

data = data.sort_by{ |name, count| -count }.to_h

puts "Total Lines Analyzed: " + data.values.reduce(:+).to_s
puts "------------------------------"

data.first(20).each_with_index do |(name, count), index|
  printf "#%02d: %-12s (%04d)\n", index+1, name, count
end

IO.write("results.json", data.to_json)
