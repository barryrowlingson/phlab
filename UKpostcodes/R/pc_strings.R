
inward <- function(pcs){
    match_pc_regex(pcs, gov_regex())[,8]
}

outward <- function(pcs){
    match_pc_regex(pcs, gov_regex())[,3]
}

components <- function(pcs){
    d = data.frame(Code=pcs,
                   Inward=inward(pcs),
                   Outward=outward(pcs))
    d$Area = pc_area(pcs)
    d$District = pc_district(pcs)
    d$Sector = pc_sector(pcs)

    return(d)

}

pc_area = function(pcs){
    stringi::stri_match_first_regex(outward(pcs),"^[A-Za-z]+")[,1]
}

pc_district = function(pcs){
    outward(pcs)
}

pc_sector = function(pcs){
    ow = outward(pcs)
    iw = inward(pcs)
    ifelse(is.na(ow)|is.na(iw),
           NA,
           paste0(ow," ",gsub("[^0-9]*$","",iw))
           )
}

pc_canonical <- function(pcs){
    ow = outward(pcs)
    iw = inward(pcs)
    ifelse(is.na(ow)|is.na(iw),
           NA,
           paste0(ow, " ", iw)
           )
}
