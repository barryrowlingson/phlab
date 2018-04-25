
random_pc_format <- Vectorize(function(s){
    s = strsplit(s,"")[[1]]
    NUMS = as.character(0:9)
    letterPos = s %in% LETTERS
    numberPos = s %in% NUMS
    nLet = sum(letterPos)
    nDig = sum(numberPos)
    s[letterPos] = sample(LETTERS, nLet, replace=TRUE)
    s[numberPos] = sample(NUMS, nDig, replace=TRUE)
    pc_canonical(paste0(s, collapse=""))
})

random_pcs <- function(formats, n){
    random_pc_format(sample(formats,n, replace=TRUE))
}
