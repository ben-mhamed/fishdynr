% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ypr.R
\name{ypr}
\alias{ypr}
\title{Yield-per-recruit}
\usage{
ypr(params, adj.params)
}
\arguments{
\item{params}{List of parameters for the population. Applies a single cohort
simulation for the initial population state using \code{\link[fishdynr]{cohortSim}}
function}

\item{adj.params}{List of 2 parameters combinations to use for yield per recruit
analysis. In the case of trawl-type selectivity, these should be levels for
F and knife-edge length at capture. For gillnet-type selectivity, these should be
levels for F and mesh_size.}
}
\value{
A list of parameter combinations used in the yield-per-recruit
exploration, plus matrix output for yield (\code{Y}) and spawning stock
biomass (\code{SB}) given the parameter combinations (\code{adj.params.comb}).
}
\description{
Sets up an yield-per-recruit exploration by adjusting fishing mortality
and selectivity using the \code{\link[fishdynr]{cohortSim}} function
}
\examples{
# Trawl-type
data(tilapia)
n <- 30
adj.params <- list(F=seq(0,3,,n), knife_edge_size=seq(0,tilapia$Linf,,n))
res <- ypr(params=tilapia, adj.params)
pal <- colorRampPalette(c(
 rgb(1,0.5,0.5), rgb(1,1,0.5), rgb(0.5,1,1), rgb(0.5,0.5,1)
))
op <- par(mfcol=c(1,2))
# Yield
image(x=res$F, y=res$knife_edge, z=res$Y, col=pal(100))
contour(x=res$F, y=res$knife_edge, z=res$Y, add=TRUE)
mtext("Yield", line=0.5, side=3)
# Relative spawning biomass
SB_F0 <- res$SB[which(res$F==0),1]
image(x=res$F, y=res$knife_edge, z=res$SB/SB_F0, col=pal(100))
contour(x=res$F, y=res$knife_edge, z=res$SB/SB_F0, add=TRUE)
mtext("Rel. Spawning Biomass", line=0.5, side=3)
par(op)

 
# Gillnet-type
data(tilapia)
tilapia$selectFun <- "gillnet"
n <- 30
adj.params <- list(F=seq(0,3,,n), mesh_size=seq(60,160,,n))
res <- ypr(params=tilapia, adj.params)
pal <- colorRampPalette(c(
 rgb(1,0.5,0.5), rgb(1,1,0.5), rgb(0.5,1,1), rgb(0.5,0.5,1)
))
op <- par(mfcol=c(1,2))
# Yield
image(x=res$F, y=res$mesh_size, z=res$Y, col=pal(100))
contour(x=res$F, y=res$mesh_size, z=res$Y, add=TRUE)
mtext("Yield", line=0.5, side=3)
# Relative spawning biomass
SB_F0 <- res$SB[which(res$F==0),1]
image(x=res$F, y=res$mesh_size, z=res$SB/SB_F0, col=pal(100))
contour(x=res$F, y=res$mesh_size, z=res$SB/SB_F0, add=TRUE)
mtext("Rel. Spawning Biomass", line=0.5, side=3)
par(op)

}
