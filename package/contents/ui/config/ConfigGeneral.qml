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
		id: formLayout

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

		// Assume the user cannot edit the file if it's in the root directory.
		readonly property string layoutFilepath: plasmoid.file("", "ui/CurrentWeatherView.qml")
		readonly property bool installedAsRoot: layoutFilepath.indexOf('/usr/share/plasma/plasmoids/') == 0
		property bool showAdvancedSection: !installedAsRoot

		Kirigami.Separator {
			visible: formLayout.showAdvancedSection
			Kirigami.FormData.label: i18n("Advanced")
			Kirigami.FormData.isSection: true
		}

		Button {
			visible: formLayout.showAdvancedSection
			Kirigami.FormData.label: i18n("Edit Layout:")
			iconName: "editor"
			text: i18n("Open Layout File")

			onClicked: {
				Qt.openUrlExternally(formLayout.layoutFilepath)
			}
		}
		// Label {
		// 	text: formLayout.layoutFilepath
		// }

		readonly property var testCommand: "plasmawindowed " + plasmoid.pluginName
		Button {
			visible: formLayout.showAdvancedSection
			Kirigami.FormData.label: i18n("Test Layout:")
			iconName: "run-build"
			text: i18n("Test Widget")

			onClicked: {
				executable.exec(formLayout.testCommand)
			}

			PlasmaCore.DataSource {
				id: executable
				engine: "executable"
				connectedSources: []
				onNewData: disconnectSource(sourceName) // cmd finished
				function exec(cmd) {
					connectSource(cmd)
				}
			}
		}
		// Label {
		// 	text: formLayout.testCommand
		// }

		Label {
			Kirigami.FormData.label: i18n("Reload Layout:")
			text: i18n("To reload the widget on your desktop, logout then back login.")
		}
	}

}
