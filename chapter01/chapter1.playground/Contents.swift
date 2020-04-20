enum 科⽬: String, CaseIterable {
    case 语⽂, 数学, 英语, 物理
}

struct Student {
    let name: String
    let scores: [科⽬: Int]
}

let s1 = Student(
    name: "Jane",
    scores: [.语⽂: 86, .数学: 92, .英语: 73, .物理: 88]
)
let s2 = Student(
    name: "Tom",
    scores: [.语⽂: 99, .数学: 52, .英语: 97, .物理: 36]
)
let s3 = Student(
    name: "Emma",
    scores: [.语⽂: 91, .数学: 92, .英语: 100, .物理: 99]
)
let students = [s1, s2, s3]

// 1. 计算所有学生的语文成绩平均分，并将其打印出来。
// 指令式
var sum1: Int = 0;
for student in students {
    for score in student.scores {
        if (score.key == 科⽬.语⽂) {
            sum1 += score.value
        }
    }
}
let average1 = sum1 / students.count
print(average1)
// 声明式
let average2 = students.map{$0.scores[.语⽂]!}.reduce(0, +) / students.count
print(average2)


// 2. 统计各个科目的及格率 (60 分以上及格)，并将及格率结果进行排序。
// 指令式
var passStu: [科⽬: Int] = [.语⽂: 0, .数学: 0, .英语: 0, .物理: 0]
for student in students {
    for score in student.scores {
        if (score.key == 科⽬.语⽂ && score.value > 60) {
            passStu[.语⽂]! += 1
        } else if (score.key == 科⽬.数学 && score.value > 60) {
            passStu[.数学]! += 1
        } else if (score.key == 科⽬.英语 && score.value > 60) {
            passStu[.英语]! += 1
        } else if (score.key == 科⽬.物理 && score.value > 60){
            passStu[.物理]! += 1
        }
    }
}

let percentageInfo: [(科⽬, Double)] = [
    (.语⽂, Double(passStu[.语⽂]!)/Double(students.count) * 100),
    (.数学, Double(passStu[.数学]!)/Double(students.count) * 100),
    (.英语, Double(passStu[.英语]!)/Double(students.count) * 100),
    (.物理, Double(passStu[.物理]!)/Double(students.count) * 100),
]

// 桶排序
func bubbleSort(sortArray:  [(科⽬, Double)]) -> [(科⽬, Double)] {
    let n = sortArray.count
    var tempArray = sortArray
    for i in 0..<n {
        for j in 0..<(n-1-i) {
            if tempArray[j].1 > tempArray[j+1].1 {
                tempArray.swapAt(j, j+1)
            }
        }
    }
    return tempArray
}
print(bubbleSort(sortArray: percentageInfo))

// 声明式
func passPercentageIn(_ aClass: 科⽬) -> Double {
    return Double(students.map{ $0.scores[aClass]! > 60 ? 1 : 0 }.reduce(0, +))  * 100 /
        Double(students.count)
}
var percentage2: [(科⽬, Double)] = []
for aClass in 科⽬.allCases {
    percentage2.append((aClass, passPercentageIn(aClass)))
}
print(percentage2.sorted{ $0.1 < $1.1 })



