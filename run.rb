
relation=nil
newLine=nil
#allAtt=Array.new() {Array.new()}
allAtt = Hash.new
dataSet=[]
auxLine=nil

input = gets
input = input.split('\n')
puts input


relation = gets.chomp
while(relation.split(' ')[0] != "@relation")
  relation = gets.chomp
end
relation = relation.split(' ')[1]
#puts "Relation: #{relation}"

newLine = gets.chomp
while(newLine.split(' ')[0] != "@attribute")
  newLine = gets.chomp
end

while(newLine.split(' ')[0] == "@attribute")
  allAtt[(":" + newLine.split(' ')[1])] = newLine.split('{')[1].gsub(/ /,'').gsub(/}/,'').split(',')
  #allAtt.push(newLine.split(' ')[1])
  #puts "AllAtt: #{allAtt}"
  newLine = gets.chomp
end

while(newLine.split(' ')[0] != "@data")
  newLine = gets.chomp
end

while newLine.split(' ')[0] != nil
  if newLine.split(' ')[0] != '%'
    dataSet.push(newLine.split(','))
  end
  newLine = gets.chomp
end

puts relation
puts allAtt
puts dataSet
