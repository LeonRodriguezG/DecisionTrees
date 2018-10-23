
relation=nil
newLine=nil
#allAtt=Array.new() {Array.new()}
allAtt = Hash.new
dataSet=[]
auxLine=nil

relation = gets.chomp
while(relation.split(' ')[0] != "@relation")
  relation = gets.chomp
end
relation = relation.split(' ')[1]
#puts "Relation: #{relation}"

newLine = gets.chomp
while(newLine.split(' ')[0] != "@attribute")
  newLine = gets.chomp
  while(newLine.split(' ')[0] == "@attribute")
    allAtt[(":" + newLine.split(' ')[1])] = newLine.split('{')[1].gsub(/ /,'').gsub(/}/,'').split(',')
    #allAtt.push(newLine.split(' ')[1])
    #puts "AllAtt: #{allAtt}"
    auxLine = newLine
    newLine = gets.chomp
  end
  newLine = auxLine if auxLine.split(' ')[0] == "@attribute"
end

newLine = gets.chomp
while(newLine.split(' ')[0] != "@data")
  newLine = gets.chomp
end
while newLine != ""
  if newLine[0] != '%'
    dataSet.push(newLine.split(','))
  end
  newLine=auxLine if auxLine.split(' ')[0] == "@attribute"
end

puts relation
puts allAtt
puts dataSet
