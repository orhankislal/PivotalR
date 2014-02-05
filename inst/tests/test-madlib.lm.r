context("Test madlib.lm")

## ----------------------------------------------------------------------
## Test preparations

## Need valid 'port' and 'dbname' values
.check.params(c("port", "dbname"), environment())

## connection ID
cid <- db.connect(port = port, dbname = dbname, verbose = FALSE)

## data in the datbase
dat.db <- as.db.data.frame(abalone, conn.id = cid, verbose = FALSE)

## data in the memory
dat.mm <- abalone

## ----------------------------------------------------------------------
## Tests

test_that("madlib.lm returns the correct class", {
    ##
    fdb <- madlib.lm(rings ~ . - id - sex, data = dat.db)
    fm <- lm(rings ~ . - id - sex, data = dat.mm)
    ##
    expect_that(fdb, is_a("lm.madlib"))
    expect_that(fdb$coef, equals(as.numeric(fm$coefficients)))
})

## ----------------------------------------------------------------------
## Clean up

db.disconnect(cid, verbose = FALSE)
