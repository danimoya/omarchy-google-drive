import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui as Ui

Ui.BarWidget {
  id: root
  moduleName: "danimoya.gdrive"
  property string statusText: "GD"
  property string statusTooltip: "Google Drive — checking mount status"
  property bool statusActive: false
  readonly property string scriptPath: decodeURIComponent(Qt.resolvedUrl("scripts/gdrive-status").toString().replace(/^file:\/\//, ""))
  readonly property string controlPath: decodeURIComponent(Qt.resolvedUrl("scripts/gdrive-control").toString().replace(/^file:\/\//, ""))
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function refresh() {
    if (!statusProcess.running) statusProcess.running = true
  }

  Process {
    id: statusProcess
    command: ["bash", root.scriptPath]
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var data = JSON.parse(text)
          root.statusText = data.text || "GD"
          root.statusTooltip = data.tooltip || "Google Drive"
          root.statusActive = data.class === "active"
        } catch (error) {
          root.statusText = "GD!"
          root.statusTooltip = "Google Drive status unavailable. Check dependencies and the user service."
          root.statusActive = true
        }
      }
    }
  }
  Process {
    id: actionProcess
    onExited: root.refresh()
  }
  Timer {
    interval: 5000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }
  Ui.WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.statusText
    tooltipText: root.statusTooltip
    active: root.statusActive
    onPressed: function(buttonCode) {
      if (actionProcess.running) return
      var action = buttonCode === Qt.RightButton ? "toggle"
        : buttonCode === Qt.MiddleButton ? "refresh" : "open"
      actionProcess.command = ["bash", root.controlPath, action]
      actionProcess.running = true
    }
  }
}
