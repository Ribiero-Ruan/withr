make_call <- function(...) {
  as.call(list(...))
}

vlapply <- function(X, FUN, ..., FUN.VALUE = logical(1)) {
  vapply(X, FUN, ..., FUN.VALUE = FUN.VALUE)
}

names2 <- function(x) {
  nms <- names(x)
  if (is.null(nms)) {
    rep("", length(x))
  } else {
    nms[is.na(nms)] <- ""
    nms
  }
}

#' Shim for tools::makevars_user()
#' @keywords internal
#' @export
makevars_user <- function() {
  if (getRversion() >= "3.3") {
    return(tools::makevars_user())
  }
  # Below is tools::makevars_user() from R 3.6.2
  m <- character()
  if (.Platform$OS.type == "windows") {
    if (!is.na(f <- Sys.getenv("R_MAKEVARS_USER", NA_character_))) {
      if (file.exists(f))
        m <- f
    }
    else if ((Sys.getenv("R_ARCH") == "/x64") && file.exists(f <- path.expand("~/.R/Makevars.win64")))
      m <- f
    else if (file.exists(f <- path.expand("~/.R/Makevars.win")))
      m <- f
    else if (file.exists(f <- path.expand("~/.R/Makevars")))
      m <- f
  }
  else {
    if (!is.na(f <- Sys.getenv("R_MAKEVARS_USER", NA_character_))) {
      if (file.exists(f))
        m <- f
    }
    else if (file.exists(f <- path.expand(paste0("~/.R/Makevars-",
            Sys.getenv("R_PLATFORM")))))
      m <- f
    else if (file.exists(f <- path.expand("~/.R/Makevars")))
      m <- f
  }
  m
}
