
NAc = NA_character_

test_data = test_pcs()
test_bad = bad_pcs()

context("Checking bad codes match to NA")

test_that("Bad codes are NA", {
    expect_true(all(is.na(test_pc_regex(test_bad))))
})

context("Checking good codes return as-is")

test_that("Good codes return", {
    expect_equal(test_pc_regex(test_data$Code),test_data$Code)
})
