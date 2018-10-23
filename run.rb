
relation=nil
newLine=nil
allAtt=[]
dataSet=[]
auxLine=nil

lines = $stdin.readlines

lineIndex=0

while(relation.split('\ ')[0]!= "@relation")
  relation = lines[lineIndex+=1]
end
relation = relation.split('\ ')[1]

while(newLine.split('\ ')[0]!= "@attribute")
  newLine = lines[lineIndex+=1]
  while(newLine.split('\ ')[0]=="@attribute")
    allAtt[0].push(newLine.split('\ ')[1])
    allAtt[1].push(newLine.split('{')[1].gsub('\ ','').gsub('}','').split(','))
    auxLine=newLine
    newLine = lines[lineIndex+=1]
  end
  newLine=auxLine if auxLine.split('\ ')[0]== "@attribute"
end

while(newLine.split('\ ')[0]!= "@data")
  newLine = lines[lineIndex+=1]
end
newLine = lines[lineIndex+=1]
while newLine != nil
  if newLine[0] =! '%'
    dataSet.push(newLine.split(','))
  end
  newLine=auxLine if auxLine.split('\ ')[0]== "@attribute"
end

puts relation
puts allAtt
