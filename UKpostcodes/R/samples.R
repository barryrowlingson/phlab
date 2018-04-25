###45678901234567890123456789012345678901234567
###45678901.2345678901.234.23456789.234567.2345

test_pcs = function(){
    pcdf = read.fwf(textConnection("
Format\tCode\tArea\tDistrict\tSector\tUnit
AA9A 9AA   EC1A 1BB     EC       1A      1   BB
AA9A  9AA  EC1A  1BB    EC       1A      1   BB
AA9A9AA    EC1A1BB      EC       1A      1   BB
A9A 9AA    W1A 0AX       W       1A      0   AX
A9A9AA     W1A0AX        W       1A      0   AX
A9A   9AA  W1A    0AX    W       1A      0   AX
A9 9AA     M1 1AE        M        1      1   AE
A99AA      M11AE         M        1      1   AE
A99 9AA    B33 8TH       B       33      8   TH
A999AA     B338TH        B       33      8   TH
AA9 9AA    CR2 6XH      CR        2      6   XH
AA99AA     CR26XH       CR        2      6   XH
AA99 9AA   DN55 1PT     DN       55      1   PT
AA999AA    DN551PT      DN       55      1   PT"),
      widths=c(11,11,4,9,7,5),
header=TRUE,
row.names=NULL,skip=1,
stringsAsFactors=FALSE)

    ## trim spaces start and finish
    
    for(n in names(pcdf)){
        pcdf[[n]]=stringi::stri_trim(pcdf[[n]])
    }

    pcdf = pcdf[order(pcdf$Area),]
    
    pcdf$Outward = paste0(pcdf$Area,pcdf$District)
    pcdf$Inward = paste0(pcdf$Sector,pcdf$Unit)

    pcdf$pc_district = paste0(pcdf$Area, pcdf$District)
    pcdf$pc_sector = paste0(pcdf$pc_district," ",pcdf$Sector)
    pcdf$pc_canonical = paste0(pcdf$Outward," ",pcdf$Inward)
    
    return(pcdf)

}

bad_pcs = function(){
    c("LA1","4YF",NA,"LAA AAA","","LA1111","123","90210","LA14 YF","LA 14YF",
      "LLLA1 4YFFF", "LA1 666YF")
}

