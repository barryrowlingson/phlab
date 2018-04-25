
fixup_regex <- function(s){
    s = gsub("\\n","",s)
    s = gsub(" ","",s)
    s
}

match_pc_regex <- function(codes, re=gov_regex()){
    stringi::stri_match_first_regex(codes, re)
}

test_pc_regex <- function(codes, re=gov_regex()){
    match_pc_regex(codes, re)[,1]
}


gov_regex <- function(){
s="
^([Gg][Ii][Rr] 0[Aa]{2}) |
(
  (
   [A-Za-z][0-9]{1,2}
   )
  |
   (
   [A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2}
   )
   |
    (
     [A-Za-z][0-9][A-Za-z]
     )
    |
    (
     [A-Za-z][A-Ha-hJ-Yj-y][0-9]?[A-Za-z]
     )
   )
 \\s*([0-9][A-Za-z]{2})
 $"


return(fixup_regex(s))
}

regex_outward <- function(){
    s = "
^(([Gg][Ii][Rr]) 0[Aa]{2}) |
(
  (
   ([A-Za-z])([0-9]{1,2})
   )
  |
   (
   ([A-Za-z][A-Ha-hJ-Yj-y])([0-9]{1,2})
   )
   |
    (
     ([A-Za-z])([0-9][A-Za-z])
     )
    |
    (
     ([A-Za-z][A-Ha-hJ-Yj-y])([0-9]?[A-Za-z])
     )
   )
 $"
    return(fixup_regex(s))
}
