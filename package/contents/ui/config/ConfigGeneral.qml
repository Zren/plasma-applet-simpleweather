import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.weather as WeatherPlugin

import "../libweather" as LibWeather
import "../libconfig" as LibConfig

LibConfig.FormKCM {
	Layout.fillWidth: true

	LibWeather.ConfigWeatherStationPicker {
		configKey: 'source'
	}
	LibWeather.WeatherStationCredits {
		id: weatherStationCredits
	}

	LibConfig.SpinBox {
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:spinbox", "Update every:")
		configKey: "updateInterval"
		suffix: i18ndc("plasma_applet_org.kde.plasma.weather", "@item:valuesuffix spacing to number + unit (minutes)", " min")
		stepSize: 5
		from: 30
		to: 3600
	}

	LibConfig.CheckBox {
		configKey: "showWarnings"
		text: i18n("Show weather warnings")
	}

	LibConfig.BackgroundToggle {}

	Kirigami.Separator {
		Kirigami.FormData.isSection: true
	}

	RowLayout {
		Kirigami.FormData.label: i18n("Font Family:")
		LibConfig.FontFamily {
			configKey: 'fontFamily'
		}
		LibConfig.TextFormat {
			boldConfigKey: 'bold'
		}
	}

	LibConfig.SpinBox {
		Kirigami.FormData.label: i18n("Min/Max Temp:")
		configKey: "minMaxFontSize"
		suffix: i18nc("font size suffix", "pt")
	}

	LibConfig.SpinBox {
		Kirigami.FormData.label: i18n("Condition:")
		configKey: "forecastFontSize"
		suffix: i18nc("font size suffix", "pt")
	}

	Kirigami.Separator {
		Kirigami.FormData.isSection: true
	}

	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("Text:")
		configKey: "textColor"
		defaultColor: Kirigami.Theme.textColor
	}


	RowLayout {
		Kirigami.FormData.label: i18n("Outline:")
		Layout.fillWidth: true
		LibConfig.CheckBox {
			id: showOutline
			configKey: "showOutline"
		}
		LibConfig.ColorField {
			Layout.fillWidth: true
			configKey: "outlineColor"
			defaultColor: Kirigami.Theme.backgroundColor
			enabled: showOutline.checked
		}
	}
}
