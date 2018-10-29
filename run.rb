
#################################################################
#
#  Function return the entropy (como se escriba)
#   of a Hash in the next form
#   InputHash['attributes'] = array of the attributes in order
#   InputHash[num] = array of the values of the data lines
#   num goes from 0 to dataLines - 1
#   Returns a double with the value of the entropy
#
################################################################

def H(dataMatrix)
  outputPos = dataMatrix[0].length - 1
  linesOfData = dataMatrix.length - 1
  outNumber = Hash.new
  sum = 0.0

  #Get the number of times that a certain value apears in the output
  linesOfData.times do |n|
    if outNumber[dataMatrix[n][outputPos]] == nil
      outNumber[dataMatrix[n][outputPos]] =  1.0
    else
      outNumber[dataMatrix[n][outputPos]] += 1.0
    end
  end
  outNumber.keys.each do |key|
    sum -= (outNumber[key]/linesOfData.to_f) * Math.log(outNumber[key]/(linesOfData).to_f,2)
  end
  return sum
end


#################################################################
#
#  Function return the gain of expaning on a certain attribute
#   of a Hash of the next form
#   InputHash['attributes'] = array of the attributes in order
#   InputHash[num] = array of the values of the data lines
#   num goes from 0 to dataLines - 1
#   Returns a double with the value of the entropy
#
################################################################

def Gain(dataMatrix , gainAttribute)
  linesOfData = dataMatrix.length - 1
  dataForAttributes = Hash.new
  attPos = nil
  sum = H(dataMatrix)
  dataMatrix['attributes'].length.times do |n|
    if dataMatrix['attributes'][n] == gainAttribute
      attPos = n
    end
  end
  linesOfData.times do |n|
    if dataForAttributes[dataMatrix[n][attPos]] == nil
      dataForAttributes[dataMatrix[n][attPos]] = Hash.new
      dataForAttributes[dataMatrix[n][attPos]]['attributes'] = dataMatrix['attributes'].dup
      dataForAttributes[dataMatrix[n][attPos]]['attributes'].delete_at(attPos)
    end
    currIndex = dataForAttributes[dataMatrix[n][attPos]].length - 1;
    dataForAttributes[dataMatrix[n][attPos]][currIndex] = dataMatrix[n].dup
    dataForAttributes[dataMatrix[n][attPos]][currIndex].delete_at(attPos)
  end
  dataForAttributes.keys.each do |key|
    sum -=  (((dataForAttributes[key].length - 1).to_f)/(linesOfData.to_f) * H(dataForAttributes[key]))
  end
  return sum
end


def Expand (dataMatrix, level=0)
  space = ""
  level.times do
    space = space + "  "
  end
  if H(dataMatrix) == 0.0
    puts "#{space}ANSWER: #{dataMatrix[0][dataMatrix[0].length - 1]}"
    return
  end
  linesOfData=dataMatrix.length - 1
  dataForAttributes = Hash.new
  gain = -1.0
  expandedAttPos = nil
  (dataMatrix['attributes'].length-1).times do |n|
    if Gain(dataMatrix,dataMatrix['attributes'][n])>gain
      expandedAttPos = n
      gain = Gain(dataMatrix,dataMatrix['attributes'][n])
    end
  end
  linesOfData.times do |n|
    if dataForAttributes[dataMatrix[n][expandedAttPos]] == nil
      dataForAttributes[dataMatrix[n][expandedAttPos]] = Hash.new
      dataForAttributes[dataMatrix[n][expandedAttPos]]['attributes'] = dataMatrix['attributes'].dup
      dataForAttributes[dataMatrix[n][expandedAttPos]]['attributes'].delete_at(expandedAttPos)
    end
    currIndex = dataForAttributes[dataMatrix[n][expandedAttPos]].length - 1;
    dataForAttributes[dataMatrix[n][expandedAttPos]][currIndex] = dataMatrix[n].dup
    dataForAttributes[dataMatrix[n][expandedAttPos]][currIndex].delete_at(expandedAttPos)
  end
  dataForAttributes.keys.each do |key|
    puts "#{space}#{dataMatrix['attributes'][expandedAttPos]}: #{key}"
    Expand(dataForAttributes[key],level+1)
  end
  return
end

#######################################################################################
#                         Reciving data (does not work with alpha grader)             #
# #####################################################################################

relation=nil
newLine=nil
allAtt = Hash.new
dataSet= Hash.new

relation = gets.chomp
while relation.split(' ')[0] != "@relation"
  relation = gets.chomp
end
relation = relation.split(' ')[1]

newLine = gets.chomp

while newLine.split(' ')[0] != "@attribute"
  newLine = gets.chomp
end
dataSet['attributes']=[]
while newLine.split(' ')[0] == "@attribute"
  allAtt[(":" + newLine.split(' ')[1])] = newLine.split('{')[1].gsub(/ /,'').gsub(/}/,'').split(',')
  dataSet['attributes'].push(newLine.split('{')[0].split(' ')[1])
  newLine = gets.chomp
end

while(newLine.split(' ')[0] != "@data")
  newLine = gets.chomp
end

#line = 0
newLine = gets.chomp
dataSet = []
while newLine != "\n"
  if newLine != "\n" && newLine[0,1] != "%"
    newLine.split(',').each do |val|
      dataSet.push(val)
    end
    #line+=1
  end
  newLine = gets.chomp
  puts "Porque? #{newLine}"
end

Expand(dataSet)