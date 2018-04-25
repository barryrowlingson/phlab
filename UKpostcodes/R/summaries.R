pc_summaries <- function(pcs){

    cps = pc_canonical(pcs)
    cc = components(cps)

    res = list(
        number = length(pcs),
        number_canonical = sum(cps == pcs, na.rm=TRUE),
        pc_area = data.frame(table(Area = cc$Area)),
        pc_district = data.frame(table(District = cc$District)),
        pc_sectors = data.frame(table(Sector = cc$Sector))
    )
    class(res)="pc_summaries"
    res
    
}

print.pc_summaries <- function(x,...){
    message(x$number," Postcodes")
    message(x$number_canonical," in canonical form")

    print(x$pc_area)

    print(x$pc_district)

    print(x$pc_sector)

}
