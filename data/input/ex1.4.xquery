declare option output:method "xml";
declare option output:indent "yes";

<topTaggedQuestions>{
  for $tag in subsequence(distinct-values(doc("anime/Tags.xml")//row/@TagName), 1, 10)
  let $tagCount := count(doc("anime/Posts.xml")//row[contains(@Tags, $tag)])
  let $taggedQuestions := doc("anime/Posts.xml")//row[contains(@Tags, $tag)]
  for $question in subsequence($taggedQuestions, 1, 100)
  let $title := $question/@Title/string()
  let $viewCount := xs:integer($question/@ViewCount)
  order by $viewCount descending
  return <question>
            <tagName>{$tag}</tagName>
            <title>{$title}</title>
            <viewCount>{$viewCount}</viewCount>
         </question>
}</topTaggedQuestions>