declare option output:method "xml";
declare option output:indent "yes";

<topTags>{
  for $tag in distinct-values(doc("anime/Tags.xml")//row/@TagName)
  let $tagCount := count(doc("anime/Posts.xml")//row[contains(@Tags, $tag)])
  order by $tagCount descending
  return <tag>
            <tagName>{$tag}</tagName>
            <tagCount>{$tagCount}</tagCount>
         </tag>
}</topTags>