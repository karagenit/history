#!/usr/bin/env ruby

require 'json'
require 'date'

totals = {}
bydate = {}
aliases = {}

binwidth = 7 #days

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
      'R'
    else
      ext
    end
  else
    command
  end
end

# load bash aliases for substitution
File.readlines("#{Dir.home}/.bash_aliases").each do |line|
  ali, command = line.match(/alias ([A-Za-z0-9]{1,})='([A-Za-z0-9\/]{1,})[\s']/i)&.captures
  aliases[ali] = command unless ali.nil? || command.nil?
end

Dir.glob('data/*').each do |file|
  date = Date.strptime(file, "data/%Y-%m-%d %H:%M.txt")
  File.readlines(file).each do |line|
    command = line.strip.split(/[\s;]/)[0]

    # Substitute Aliases
    command = aliases[command] unless aliases[command].nil?
    command = sub_scripts(command)

    totals[command] = totals[command].to_i + 1

    bin = (date - ((date.yday - 1) % binwidth)).strftime("%Y-%m-%d")

    bydate[command] = {} if bydate[command].nil?
    bydate[command][bin] = bydate[command][bin].to_i + 1
  end
end

totals = totals.sort_by{ |name, count| -count }.to_h

puts "Total Lines Analyzed: " + totals.values.reduce(:+).to_s
puts "------------------------------"

totals.first(20).each_with_index do |(name, count), index|
  printf "#%02d: %-12s (%04d)\n", index+1, name, count
end

File.write("output/totals.json", totals.to_json)
File.write("output/dates.json", bydate.to_json)
