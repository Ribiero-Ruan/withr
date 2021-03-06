context("tempfile")

test_that("with_tempfile works", {

  f1 <- character()
  f2 <- character()

  with_tempfile("file1", {
    writeLines("foo", file1)
    expect_equal(readLines(file1), "foo")
    with_tempfile("file2", {
      writeLines("bar", file2)
      expect_equal(readLines(file1), "foo")
      expect_equal(readLines(file2), "bar")

      f2 <<- file2
    })
    expect_false(file.exists(f2))
    f1 <<- file1
  })
  expect_false(file.exists(f1))
})

test_that("local_tempfile with `new` works with a warning", {

  f1 <- character()
  f2 <- character()

  f <- function() {
    expect_warning(
      local_tempfile("file1"),
      "is deprecated"
    )
    writeLines("foo", file1)
    expect_equal(readLines(file1), "foo")
    expect_warning(
      local_tempfile("file2"),
      "is deprecated"
    )
    writeLines("bar", file2)
    expect_equal(readLines(file1), "foo")
    expect_equal(readLines(file2), "bar")
    f1 <<- file1
    f2 <<- file2
  }
  f()

  expect_false(file.exists(f1))
  expect_false(file.exists(f2))
})

test_that("local_tempfile works", {
  f1 <- character()
  f2 <- character()

  f <- function() {
    file1 <- local_tempfile()

    writeLines("foo", file1)
    expect_equal(readLines(file1), "foo")

    file2 <- local_tempfile()
    writeLines("bar", file2)
    expect_equal(readLines(file1), "foo")
    expect_equal(readLines(file2), "bar")
    f1 <<- file1
    f2 <<- file2
  }
  f()

  expect_false(file.exists(f1))
  expect_false(file.exists(f2))
})
