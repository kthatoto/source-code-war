#!/usr/bin/env ruby
30.times do
  line = ''
  100.times do
    line += rand > 0.5 ? '<' : '>'
  end
  puts line
end
