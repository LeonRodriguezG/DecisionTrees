
relation=nil
newLine=nil
allAtt=[]
dataSet=[]
auxLine=nil

#Por favor 

while(relation.split('\ ')[0]!= "@relation")
  relation = gets.chomp
end
relation = relation.split('\ ')[1]

while(newLine.split('\ ')[0]!= "@attribute")
  newLine = gets.chomp
  while(newLine.split('\ ')[0]=="@attribute")
    allAtt[0].push(newLine.split('\ ')[1])
    allAtt[1].push(newLine.split('{')[1].gsub('\ ','').gsub('}','').split(','))
    auxLine=newLine
    newLine = gets.chomp
  end
  newLine=auxLine if auxLine.split('\ ')[0]== "@attribute"
end

while(newLine.split('\ ')[0]!= "@data")
  newLine = gets.chomp
end
newLine = gets.chomp
while newLine != ""
  if newLine[0] =! '%'
    dataSet.push(newLine.split(','))
  end
  newLine=auxLine if auxLine.split('\ ')[0]== "@attribute"
end

puts relation
puts allAtt
