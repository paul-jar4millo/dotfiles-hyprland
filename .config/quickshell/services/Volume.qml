pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property url icon: {
        if (!Pipewire.defaultAudioSink) return Qt.resolvedUrl("../assets/icons/volume-mute-fill.svg")
        if (Pipewire.defaultAudioSink.audio && Pipewire.defaultAudioSink.audio.muted) return Qt.resolvedUrl("../assets/icons/volume-mute-fill.svg")
        var vol = Pipewire.defaultAudioSink.audio ? Pipewire.defaultAudioSink.audio.volume : 0
        if (vol === 0) return Qt.resolvedUrl("../assets/icons/volume-off-fill.svg")
        if (vol < 0.5) return Qt.resolvedUrl("../assets/icons/volume-down-fill.svg")
        return Qt.resolvedUrl("../assets/icons/volume-up-fill.svg")
    }

    readonly property string percentage: Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%" : "0%"
}
