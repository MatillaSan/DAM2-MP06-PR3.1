declare option output:method "xml";
declare option output:indent "yes";

<topUsers>{
  for $user in distinct-values(doc("anime/Posts.xml")//row/@OwnerUserId)
  let $username := doc("anime/Users.xml")//row[@Id = $user]/@DisplayName/string()
  let $questionCount := count(doc("anime/Posts.xml")//row[@OwnerUserId = $user and @PostTypeId = 1])
  order by $questionCount descending
  return <user>
            <username>{$username}</username>
            <questionCount>{$questionCount}</questionCount>
         </user>
}</topUsers>