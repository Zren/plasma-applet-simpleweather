import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.kirigami 2.3 as Kirigami

import "../lib"

ConfigPage {
	id: page
	showAppletVersion: true

	WeatherStationPickerDialog {
		id: stationPicker

		onAccepted: {
			plasmoid.configuration.source = source
		}
	}

	Kirigami.FormLayout {
		Layout.fillWidth: true

		RowLayout {
			Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label", "Location:")
			Label {
				id: locationDisplay
				Layout.fillWidth: true
				elide: Text.ElideRight

				text: {
					var sourceDetails = plasmoid.configuration.source.split('|')
					if (sourceDetails.length > 2) {
						return i18ndc("plasma_applet_org.kde.plasma.weather",
							"A weather station location and the weather service it comes from", "%1 (%2)",
							sourceDetails[2], sourceDetails[0])
					}
					return i18ndc("plasma_applet_org.kde.plasma.weather", "no weather station", "-")
				}
			}
			Button {
				id: selectButton
				iconName: "edit-find"
				text: i18ndc("plasma_applet_org.kde.plasma.weather", "@action:button", "Select")
				onClicked: stationPicker.visible = true
			}
		}

		WeatherStationCredits {
			id: weatherStationCredits
		}

		ConfigSpinBox {
			Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:spinbox", "Update every:")
			configKey: "updateInterval"
			suffix: i18ndc("plasma_applet_org.kde.plasma.weather", "@item:valuesuffix spacing to number + unit (minutes)", " min")
			stepSize: 5
			minimumValue: 30
			maximumValue: 3600
		}

		ConfigCheckBox {
			configKey: "showWarnings"
			text: i18n("Show weather warnings")
		}

		ConfigCheckBox {
			configKey: "showBackground"
			text: i18n("Desktop Widget: Show background")
		}

		Kirigami.Separator {
			Kirigami.FormData.isSection: true
		}

		RowLayout {
			Kirigami.FormData.label: i18n("Font Family:")
			ConfigFontFamily {
				configKey: 'fontFamily'
			}
			ConfigTextFormat {
				boldConfigKey: 'bold'
			}
		}

		ConfigSpinBox {
			Kirigami.FormData.label: i18n("Min/Max Temp:")
			configKey: "minMaxFontSize"
			suffix: i18nc("font size suffix", "pt")
		}

		ConfigSpinBox {
			Kirigami.FormData.label: i18n("Condition:")
			configKey: "forecastFontSize"
			suffix: i18nc("font size suffix", "pt")
		}

		Kirigami.Separator {
			Kirigami.FormData.isSection: true
		}

		ConfigColor {
			Kirigami.FormData.label: i18n("Text:")
			configKey: "textColor"
			defaultColor: theme.textColor
			label: ""
		}

		ConfigColor {
			Kirigami.FormData.label: i18n("Outline:")
			configKey: "outlineColor"
			defaultColor: theme.backgroundColor
			label: ""

			property string checkedConfigKey: "showOutline"
			Kirigami.FormData.checkable: true
			Kirigami.FormData.checked: checkedConfigKey ? plasmoid.configuration[checkedConfigKey] : false
			Kirigami.FormData.onCheckedChanged: {
				if (checkedConfigKey) {
					plasmoid.configuration[checkedConfigKey] = Kirigami.FormData.checked
				}
			}
			enabled: Kirigami.FormData.checked
		}
	}

}
