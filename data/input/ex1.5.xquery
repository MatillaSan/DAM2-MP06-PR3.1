declare option output:method "xml";
declare option output:indent "yes";

<topScoredQuestions>{
  for $question in subsequence(doc("anime/Posts.xml")//row[@PostTypeId = 1], 1, 10)
  let $title := $question/@Title/string()
  let $score := xs:integer($question/@Score)
  let $topAnswer := doc("anime/Posts.xml")//row[@PostTypeId = 2 and @ParentId = $question/@Id][1]
  let $answerBody := $topAnswer/@Body/string()
  let $answerScore := xs:integer($topAnswer/@Score)
  return <question>
            <title>{$title}</title>
            <score>{$score}</score>
            <topAnswer>
              <body>{$answerBody}</body>
              <score>{$answerScore}</score>
            </topAnswer>
         </question>
}</topScoredQuestions>