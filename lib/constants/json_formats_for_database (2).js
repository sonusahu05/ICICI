var latestQuestionResponses = 
{
    responses: [
        {
            qid: "0",
            height: 178,
            weight: 75.2,
            waistSize: 40
        },
        {
            qid: "1",
            question: "some question",
            score: 3
        },
        {
            qid: "2",
            question: "some question",
            score: 5
        }
    ]
};

var allQuestionsResponses = 
{
    responses: [
        [
            {
                rid: "1",
                timestamp: "timestamp"
            }, // First element of this array will be meta data for that particular response
            {
                qid: "0",
                height: 178,
                weight: 75.2,
                waistSize: 40
            },
            {
                qid: "1",
                question: "some question",
                score: 3
            },
            {
                qid: "2",
                question: "some question",
                score: 5
            }
        ],
        [
            {
                rid: "2",
                timestamp: "timestamp"
            }, // First element of this array will be meta data for that particular response
            {
                qid: "0",
                height: 178,
                weight: 75.2,
                waistSize: 40
            },
            {
                qid: "1",
                question: "some question",
                score: 3
            },
            {
                qid: "2",
                question: "some question",
                score: 5
            }
        ]
    ]
}

var indexScores = 
{
    scores: [
        {
            sid: "1",
            timestamp: "timestamp",
            bmi: 24.8,
            whr: 0.56,
            nutrition: 79,
            lifestyle: 89,
            stress: 68,
            emotion: 77,
            wellness: 78.25
        },
        {
            sid: "2",
            timestamp: "timestamp",
            bmi: 24.8,
            whr: 0.56,
            nutrition: 59,
            lifestyle: 99,
            stress: 73,
            emotion: 75,
            wellness: 76.5
        }
    ]
};

var questionDetails =
{
    sections: [
        {
            name: "PersonalDetails",
            questions: [
                {
                    id: "1",
                    question: "abcd",
                    optionType: "distinct",
                    options: ['a', 'b', 'c', 'd']
                }
            ]
        },
        {
            name: "Nutrition",
            questions: [
                {
                    id: "1",
                    pivotType: "veg/non-veg/vegan",
                    goodRemark: "remark",
                    excellentRemark: "remark",
                    focusRemark: "remark",
                    weight: 0.2,
                    optionType: "distinct",
                    options: ['a', 'b', 'c', 'd', 'e']
                },
                {
                    id: "2",
                    pivotType: "veg/vegan/non-veg",
                    goodRemark: "remark",
                    excellentRemark: "remark",
                    focusRemark: "remark",
                    weight: 0.2,
                    optionType: "numeric",
                    options: ['a', 'e']
                }
            ]
        },
        {
            name: "Lifestyle|Stress|Emotion",
            questions: [
                {
                    id: "3",
                    pivotType: "NA",
                    question: "some question",
                    goodRemark: "remark",
                    excellentRemark: "remark",
                    focusRemark: "remark",
                    weight: 0.2,
                    optionType: "distinct",
                    options: ['a', 'b', 'c', 'd', 'e']
                },
                {
                    id: "4",
                    pivotType: "NA",
                    question: "some question",
                    goodRemark: "remark",
                    excellentRemark: "remark",
                    focusRemark: "remark",
                    weight: 0.2,
                    optionType: "numeric",
                    options: ['a', 'e']
                }
            ]
        }
    ]
};

var sectionDetails = 
{
    goodRemark: "remark",
    excellentRemark: "remark",
    focusRemark: "remark"
};

// console.log(typeof(index_scores));