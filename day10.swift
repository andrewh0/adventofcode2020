import Foundation

let input = """
73
114
100
122
10
141
89
70
134
2
116
30
123
81
104
42
142
26
15
92
56
60
3
151
11
129
167
76
18
78
32
110
8
119
164
143
87
4
9
107
130
19
52
84
55
69
71
83
165
72
156
41
40
1
61
158
27
31
155
25
93
166
59
108
98
149
124
65
77
88
46
14
64
39
140
95
113
54
66
137
101
22
82
21
131
109
45
150
94
36
20
33
49
146
157
99
7
53
161
115
127
152
128
"""

let input2 = """
16
10
15
5
1
11
7
19
6
12
4
"""

let input3 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

var joltageRatings = input.components(separatedBy: "\n").map { Int($0)! }
joltageRatings.sort()

func countDifferences(ratings: [Int]) -> [Int: Int] {
    var d = [Int: Int]()
    var currJoltage = 0
    var currIndex = 0

    while currIndex < ratings.count {
        let diff = ratings[currIndex] - currJoltage
        if let count = d[diff] {
            d[diff] = count + 1
        } else {
            d[diff] = 1
        }
        currJoltage = ratings[currIndex]
        currIndex += 1
    }

    if let count_3 = d[3] {
        d[3] = count_3 + 1
    }
    return d
}

func part1() -> Int {
    let differences = countDifferences(ratings: joltageRatings)
    let ones = differences[1]!
    let threes = differences[3]!
    return ones * threes
}

print(part1())

func countWays(ratings: [Int]) -> Int {
    var cache = [String: Int]()
    func countWaysHelper(lastJoltage _: Int, currIndex: Int) -> Int {
        if currIndex >= ratings.count {
            return 0
        } else if currIndex == ratings.count - 1 {
            return 1
        } else {
            var currJoltage = 0
            // This was tricky!
            if currIndex > -1 {
                currJoltage = ratings[currIndex]
            }
            var nextIndices = [Int]()
            var i = currIndex + 1
            while i < ratings.count, ratings[i] - currJoltage <= 3, ratings[i] - currJoltage > 0 {
                nextIndices.append(i)
                i += 1
            }
            var result = 0
            for nextIndex in nextIndices {
                let key = "\(currJoltage),\(nextIndex)"
                if let r = cache[key] {
                    result += r
                } else {
                    let r = countWaysHelper(lastJoltage: currJoltage, currIndex: nextIndex)
                    cache[key] = r
                    result += r
                }
            }
            return result
        }
    }
    return countWaysHelper(lastJoltage: 0, currIndex: -1)
}

func part2() -> Int {
    return countWays(ratings: joltageRatings)
}

print(part2())
