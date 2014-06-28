# Soft Wrap Indicator

Adds an indicator to the status bar that lights up if the active editor has soft wrap enabled.

Indicator Lit:

![Indicator Lit](https://raw.githubusercontent.com/lee-dohm/soft-wrap-indicator/master/indicator-lit.png)

Indicator Dark:

![Indicator Dark](https://raw.githubusercontent.com/lee-dohm/soft-wrap-indicator/master/indicator-dark.png)

## Styles

The soft wrap indicator can be styled using the following classes:

* `.soft-wrap-indicator` - For styling all instances of the indicator
* `.soft-wrap-indicator.lit` - For styling the indicator when lit

It uses the following values from `ui-variables` as defaults in order to blend in to your theme:

* `@text-color` - Text color when not lit
* `@text-color-highlight` - Text color when lit

By default it also includes a blurred text shadow to give it a kind of glow when lit.
