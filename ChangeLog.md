## v9 - March 14 2024

* Port to Qt6 / Plasma6
* Updated Dutch translation by @Vistaus (Pull Request #21)

## v8 - February 13 2022

* Port to `QtQuick.Controls 2.0`, `PlasmaComponents 3.0`, and `Kirigami` config. Should work in Ubuntu 20.04 with Qt 5.12 and KDE Frameworks 5.68.
* Merge changes to weather widget from upstream KDE weather widget.
* Port missing `ServiceListModel` in Plasma 5.24 to use the `weatherDataSource.data['ions']` to get the list of weather data websites.
* Use PlasmaCore Unit/Theme singletons.
* Refactor dailyForecastModel to check if data exists.
* Update i18n scripts.
* Add Croatian translations by @VladimirMikulic (Pull Request #18 and #19)
* Add Slovenian translations by @Ugowsky (Issue #20)
* Updated Russian translations by @Morion-Self (synced from condensedweather)

## v7 - May 4 2020

* Add ability to change Temp units.
* Update WeatherLib.
* Fix scrollbar overlap in settings.
* Updated Spanish translation by @iyanmv (Pull Request #14)
* Updated Dutch translation by @Vistaus (Pull Request #13 + #16)

## v6 - July 24 2019

* Configurable Min/Max Temp & Conditions Font Size (Issue #8)
* Use Software Rendering with text larger than 300px (Issue #9)
* Add the ability to change the text color or show a text outline (Issue #11)

## v5 - May 25 2019

* Center align the current temp/icon when thinner than the forecast text.
* Round current temp to an integer (only envcan needed it).
* Show the weather source's credits text and link.
* Brazillian Portegeus translations by @herzenschein (Pull Request #7)

## v4 - February 27 2019

* Show weather warnings (envcan only).
* Remove whitespace between min/max temp and current temp.
* Don't round weather icon to fixed sizes when medium/small.
* Updated Dutch translation (Pull Request #6)

## v3 - February 2 2019

* Fixed compatibility with openSUSE Leap with Plasma 5.12 / KDE Frameworks 5.45 / Kirigami 2.4 (Issue #2) and wetter not displaying an icon (Issue #4).
* Fix widget min size when config button is shown.
* Fix min/max temp labels being 200px wide when empty (Eg: env canada).

## v2 - January 30 2019

* Hide the min/max temp label if it's not populated (Eg: Env Canada).
* Show an icon in place of the current temp when it's not populated (Eg: Wetter).
* Added Dutch translation (Pull Request #1)
* Fix selecting the default font after changing to another font.

## v1 - January 29 2019

* Implement a simple text weather forecast with min/max/current temps.
