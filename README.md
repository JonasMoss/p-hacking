
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Modelling publication bias and *p*-hacking <img src="man/figures/logo.png" align="right" width="128" height="110" />

<!--[![Build Status](https://travis-ci.org/JonasMoss/standardized.svg?branch=master)](https://travis-ci.org/JonasMoss/standardized) -->

<!--[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JonasMoss/standardized?branch=master&svg=true)](https://ci.appveyor.com/project/JonasMoss/standardized) -->

<!--[![CircleCI build status](https://circleci.com/gh/JonasMoss/standardized.svg?style=svg)](https://circleci.com/gh/JonasMoss/standardized) -->

<!--[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)-->

<!--[![Project Status: Unsupported – The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.](https://www.repostatus.org/badges/latest/unsupported.svg)](https://www.repostatus.org/#unsupported) -->

<!--[![DOI](https://zenodo.org/badge/120678148.svg)](https://zenodo.org/badge/latestdoi/120678148) -->

Repository for the paper “Modelling publication bias and *p*-hacking”.
Contains the code required to reproduce the [arXiv
version](https://arxiv.org/abs/1911.12445) of the paper.

## Overview

The `R` folder contains the `R` code used for the simulations and the
two examples in the paper. The `data` folder contains summaries of the
simulations, while `plots` contains the plots generated in `R`,
`figures` contains Latex figures, and `tables` contains tables generated
by `R`. The paper itself is `main.text`.

The estimation of the models have been done with the
[`publipha`](https://github.com/JonasMoss/publipha) package.
