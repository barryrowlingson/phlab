context("Extracting inward from strings")

NAc = NA_character_

test_data = test_pcs()
test_bad = bad_pcs()

test_that("Inward code format", {
    expect_equal(inward(test_data$Code), test_data$Inward)
})

test_that("Bad inward codes", {
    expect_true(all(is.na(inward(test_bad))))
})

context("Extracting outward from strings")

test_that("Outward code format", {
    expect_equal(outward(test_data$Code),test_data$Outward)
})

test_that("Bad outward codes", {
    expect_true(all(is.na(outward(test_bad))))
})

context("Sub-units")

test_that("Good Sectors", {
    expect_equal(pc_sector(test_data$Code), test_data$pc_sector)
})

test_that("Bad Sectors",
{
    expect_true(all(is.na(pc_sector(test_bad))))
}
)

context("NA inputs")

test_that("outward NA = NA",
{
    expect_error(all(is.na(outward(NA))))
    expect_true(all(is.na(outward(c(NA,NA)))))
}
)
