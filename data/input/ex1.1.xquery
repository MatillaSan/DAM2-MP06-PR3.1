declare option output:method "xml";
declare option output:indent "yes";

<posts>{
  for $question in doc("anime/Posts.xml")//row
  let $title := $question/@Title/string()
  let $viewCount := xs:integer($question/@ViewCount)
  order by $viewCount descending
  return <post>
            <title>{$title}</title>
            <viewCount>{$viewCount}</viewCount>
         </post>
}</posts>