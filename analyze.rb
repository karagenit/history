#!/usr/bin/env ruby

data = {}

Dir.glob('data/*').each do |file|
  File.readlines(file).each do |line|
    # TODO: substitute aliases
    command = line.strip.split(/[\s;]/)[0]
    if data[command].nil?
      data[command] = 1
    else
      data[command] += 1
    end
  end
end

data = data.sort_by{ |name, count| -count }.to_h

data.first(10).each_with_index do |(name, count), index|
  #puts "##{index+1}: #{name}\t(#{count})"
  printf "#%02d: %-8s (%03d)\n", index+1, name, count
end
