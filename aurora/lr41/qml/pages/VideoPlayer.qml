import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.6

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Video {
        id: videoPlayer
        width: parent.width
        height: parent.height
        source: "video.mp4"
        autoPlay: true
    }
    Button {
        id: playPauseButton
        width: parent.width
        height: Theme.itemSizeLarge
        backgroundColor: "#785394"
        text: videoPlayer.playbackState === MediaPlayer.PlayingState ? "Пауза" : "Воспроизведение"
        anchors.bottom: parent.bottom
        onClicked:{
            if (videoPlayer.playbackState === MediaPlayer.PlayingState) {
                videoPlayer.pause()
                playPauseButton.text = "Воспроизведение"
            } else {
                videoPlayer.play()
                playPauseButton.text = "Пауза"
            }
        }
    }
    Button {
        id: rewindButton
        width: parent.width
        height: Theme.itemSizeLarge
        text: "Стоп"
        backgroundColor: "#785394"
        anchors.bottom: playPauseButton.top
        onClicked: {
            videoPlayer.stop()
        }
    }
}
