
relation=nil
newLine=nil
#allAtt=Array.new() {Array.new()}
allAtt = Hash.new
dataSet=[]
auxLine=nil

relation = gets
while(relation.split(' ')[0] != "@relation")
  relation = gets
end
relation = relation.split(' ')[1]
#puts "Relation: #{relation}"

newLine = gets
while(newLine.split(' ')[0] != "@attribute")
  newLine = gets
end

while(newLine.split(' ')[0] == "@attribute")
  allAtt[(":" + newLine.split(' ')[1])] = newLine.split('{')[1].gsub(/ /,'').gsub(/}/,'').split(',')
  #allAtt.push(newLine.split(' ')[1])
  #puts "AllAtt: #{allAtt}"
  newLine = gets
end

while(newLine.split(' ')[0] != "@data")
  newLine = gets
end

while newLine.split(' ')[0] != nil
  if newLine.split(' ')[0] != '%'
    dataSet.push(newLine.split(','))
  end
  newLine = gets
end

puts relation
puts allAtt
puts dataSet
