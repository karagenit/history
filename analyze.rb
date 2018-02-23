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

p data
