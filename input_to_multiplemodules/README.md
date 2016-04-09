<!-- README.md is generated from README.Rmd. Please edit that file -->
Input(s) passed to multiple modules
===================================

This series of examples illustrates the design pattern of passing one or more inputs through to another module.

[01\_original.R](01_original.R)
-------------------------------

The standard shiny app example with some comments removed for brevity.

![](README/original.png)

[02\_singlegloballevelinput.R](02_singlegloballevelinput.R)
-----------------------------------------------------------

Push an input parameter created at the app level to two instances of a chart module.

![](README/simplePassthrough.png)

An in-depth explanation is available on my [blog post](http://itsalocke.com/shiny-module-design-pattern-pass-inputs-one-module-another/)

[03\_inputmodule.R](03_inputmodule.R)
-------------------------------------

Use a input parameter from one module in another module.

![](README/inputPassthrough.png)
