str = "Jon Wade's Life"
chr = str.chars
chr.each { |i|
   if i=="'"
     chr.delete(i)
   end
}
str = chr.join
puts str
