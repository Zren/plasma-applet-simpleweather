import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

ColumnLayout {
	id: currentWeatherView

	//--- Settings
	spacing: 0

	readonly property int minMaxFontSize: plasmoid.configuration.minMaxFontSize * Screen.devicePixelRatio
	readonly property int forecastFontSize: plasmoid.configuration.forecastFontSize * Screen.devicePixelRatio

	readonly property int minMaxSeparatorWidth: minMaxFontSize * 1.4


	//--- Layout
	RowLayout {
		spacing: Kirigami.Units.smallSpacing

		ColumnLayout {
			spacing: Kirigami.Units.smallSpacing

			WLabel {
				readonly property var value: weatherData.todaysTempHigh
				readonly property bool hasValue: !isNaN(value)
				text: hasValue ? weatherData.formatTempShort(value) : ""
				Layout.preferredWidth: hasValue ? implicitWidth : 0
				font.pixelSize: currentWeatherView.minMaxFontSize
				Layout.alignment: Qt.AlignHCenter

				// Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#f00"}
			}

			Rectangle {
				visible: !isNaN(weatherData.todaysTempHigh) || !isNaN(weatherData.todaysTempLow)
				color: forecastLayout.textColor
				implicitWidth: currentWeatherView.minMaxSeparatorWidth + border.width*2
				implicitHeight: 1 * Screen.devicePixelRatio + border.width*2
				border.width: (forecastLayout.showOutline ? 1 : 0) * Screen.devicePixelRatio
				border.color: forecastLayout.outlineColor
				Layout.alignment: Qt.AlignHCenter
			}


			WLabel {
				readonly property var value: weatherData.todaysTempLow
				readonly property bool hasValue: !isNaN(value)
				text: hasValue ? weatherData.formatTempShort(value) : ""
				Layout.preferredWidth: hasValue ? implicitWidth : 0
				font.pixelSize: currentWeatherView.minMaxFontSize
				Layout.alignment: Qt.AlignHCenter

				// Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#f00"}
			}
		}

		Item {
			implicitWidth: currentTempLabel.hasValue ? currentTempLabel.contentWidth : currentForecastIcon.implicitWidth
			Layout.minimumWidth: implicitWidth
			Layout.minimumHeight: 18 * Screen.devicePixelRatio
			Layout.alignment: Qt.AlignHCenter
			Layout.fillHeight: true

			// Note: wettercom does not have a current temp
			WLabel {
				id: currentTempLabel
				anchors.centerIn: parent
				readonly property var value: weatherData.currentTemp
				readonly property bool hasValue: !isNaN(value)
				text: hasValue ? weatherData.formatTempShort(value) : ""
				fontSizeMode: Text.FixedSize
				font.pixelSize: parent.height
				height: implicitHeight

				// [Qt5/Plasma5] Workaround for Issue #9 where Plasma might crash in OpenSuse if
				// the Text is larger than 320px and using NativeRendering. Manjaro
				// does not crash, instead it draws nothing.
				// * https://github.com/Zren/plasma-applet-simpleweather/issues/9
				// * https://github.com/KDE/plasma-framework/blob/master/src/declarativeimports/plasmacomponents/qml/Label.qml
				// readonly property var plasmaRenderingType: QtQuickControlsPrivate.Settings.isMobile || Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
				// renderType: height > 300 ? Text.QtRendering : plasmaRenderingType

				// Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#ff0" }
			}

			// Note: wettercom does not have a current temp so use an icon instead
			Kirigami.Icon {
				id: currentForecastIcon
				anchors.centerIn: parent
				implicitWidth: parent.height
				implicitHeight: parent.height
				visible: !currentTempLabel.hasValue
				source: weatherData.currentConditionIconName
				roundToIconSize: false
			}

			// Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#f00"}
		}
	}

	WLabel {
		id: currentConditionsLabel
		text: weatherData.todaysForecastLabel
		font.pixelSize: currentWeatherView.forecastFontSize
		horizontalAlignment: Text.AlignHCenter

		Layout.fillWidth: true
		Layout.preferredWidth: 160 * Screen.devicePixelRatio
		elide: Text.ElideRight

		PlasmaCore.ToolTipArea {
			anchors.fill: parent
			mainText: currentConditionsLabel.text
			enabled: currentConditionsLabel.truncated
		}

		// Rectangle { anchors.fill: parent; color: "transparent"; border.width: 1; border.color: "#f00"}
	}

}
