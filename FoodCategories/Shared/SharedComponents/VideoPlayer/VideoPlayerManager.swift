//
//  VideoPlayerManager.swift
//  TestOf2P
//
//  Created by Majd Aldeyn Ez Alrejal on 31/08/2025.
//

import AVKit
import Combine

class VideoPlayerManager: NSObject, ObservableObject {
    @Published var player = AVPlayer()
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var isPlaying = false
    @Published var isMuted = false
    @Published var playbackRate: Float = 1.0
    @Published var isPIPActive = false
    
    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()
    
    var currentTimeString: String {
        formatTime(currentTime)
    }
    
    var durationString: String {
        formatTime(duration)
    }
    
    override init() {
        super.init()
        setupObservers()
    }
    
    func loadVideo(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        
        // Observe duration
        playerItem.publisher(for: \.status)
            .sink { [weak self] status in
                if status == .readyToPlay {
                    self?.duration = playerItem.duration.seconds
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupObservers() {
        // Time observer for current time
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }
        
        // Playback status observer
        player.publisher(for: \.timeControlStatus)
            .sink { [weak self] status in
                self?.isPlaying = status == .playing
            }
            .store(in: &cancellables)
    }
    
    func togglePlayPause() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
            player.rate = playbackRate
        }
    }
    
    func seekToTime(_ time: Double) {
        let targetTime = CMTime(seconds: time, preferredTimescale: 600)
        player.seek(to: targetTime)
    }
    
    func seekForward(_ seconds: Double) {
        let newTime = min(currentTime + seconds, duration)
        seekToTime(newTime)
    }
    
    func seekBackward(_ seconds: Double) {
        let newTime = max(currentTime - seconds, 0)
        seekToTime(newTime)
    }
    
    func setPlaybackRate(_ rate: Float) {
        playbackRate = rate
        if isPlaying {
            player.rate = rate
        }
    }
    
    func toggleMute() {
        isMuted.toggle()
        player.isMuted = isMuted
    }
    
    func togglePIP() {
        #if os(iOS)
        let pipController = AVPictureInPictureController(playerLayer: AVPlayerLayer(player: player))
        if pipController?.isPictureInPictureActive == true {
            pipController?.stopPictureInPicture()
        } else {
            pipController?.startPictureInPicture()
        }
        isPIPActive = pipController?.isPictureInPictureActive ?? false
        #endif
    }
    
    private func formatTime(_ time: Double) -> String {
        guard !time.isNaN && !time.isInfinite else { return "00:00" }
        
        let totalSeconds = Int(time)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    func cleanup() {
        if let timeObserver = timeObserver {
            player.removeTimeObserver(timeObserver)
        }
        player.pause()
        cancellables.forEach { $0.cancel() }
    }
}
