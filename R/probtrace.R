#' Function to calculate probability trace lines
#'
#' Given an internal mirt object extracted from an estimated model
#' compute the probability trace lines for all categories.
#'
#' @aliases probtrace
#' @param x an extracted internal mirt object containing item information (see \code{\link{extract.item}})
#' @param Theta a vector (unidimensional) or matrix (unidimensional/multidimensional) of
#'   latent trait values
#' @keywords tracelines
#'
#' @author Phil Chalmers \email{rphilip.chalmers@@gmail.com}
#' @references
#' Chalmers, R., P. (2012). mirt: A Multidimensional Item Response Theory
#' Package for the R Environment. \emph{Journal of Statistical Software, 48}(6), 1-29.
#' \doi{10.18637/jss.v048.i06}
#' @export probtrace
#' @seealso
#' \code{\link{extract.item}}
#' @examples
#'
#' mod <- mirt(Science, 1)
#' extr.2 <- extract.item(mod, 2)
#' Theta <- matrix(seq(-4,4, by = .1))
#' traceline <- probtrace(extr.2, Theta)
#' head(data.frame(traceline, Theta=Theta))
#'
probtrace <- function(x, Theta){
    if(missing(x)) missingMsg('x')
    if(missing(Theta)) missingMsg('Theta')
    if(is(Theta, 'vector')) Theta <- as.matrix(Theta)
    if(!is.matrix(Theta)) stop('Theta input must be a matrix', call.=FALSE)
    if(ncol(Theta) != x@nfact)
        stop('Theta does not have the correct number of dimensions', call.=FALSE)
    P <- ProbTrace(x=x, Theta=Theta)
    cats <- 1:ncol(P)
    if(ncol(P) == 2) cats <- cats - 1
    colnames(P) <- paste0('P.', cats)
    P
}
