//
//  VideoPlayerView.swift
//  FoodCategories
//
//  Created by Majd Aldeyn Ez Alrejal on 31/08/2025.
//

import SwiftUI
import AVKit
import Combine

struct ContentViewWW: View {
    @State private var showVideoPlayer = false
    let videoURL: URL
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showVideoPlayer = true
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                            .font(.title)
                        Text("Play Video")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showVideoPlayer) {
                }
            }
            .navigationTitle("Video Player")
        }
    }
}

struct VideoPlayerView: View {
    @StateObject private var playerManager = VideoPlayerManager()
    @State private var showControls = true
    @State private var controlsTimer: Timer?
    @State private var isPlaying = false
    @Environment(\.presentationMode) var presentationMode
    
    let videoURL: URL
    
    var body: some View {
        ZStack {
            // Video Player
            VideoPlayer(player: playerManager.player)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    toggleControls()
                }
            
            // Controls Overlay
            if showControls {
                VStack {
                    // Top Controls
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            playerManager.togglePIP()
                        }) {
                            Image(systemName: playerManager.isPIPActive ? "pip.exit" : "pip.enter")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    Spacer()
                    
                    // Center Play Button
                    Button(action: {
                        playerManager.togglePlayPause()
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    // Bottom Controls
                    VStack(spacing: 12) {
                        // Progress Slider
                        HStack {
                            Text(playerManager.currentTimeString)
                                .font(.caption)
                                .foregroundColor(.white)
                            
                            CustomSlider(value: $playerManager.currentTime, range: 0...playerManager.duration) { editing in
                                if !editing {
                                    playerManager.seekToTime(playerManager.currentTime)
                                }
                            }
                            .frame(height: 30)
                            
                            Text(playerManager.durationString)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        
                        // Control Buttons
                        HStack(spacing: 30) {
                            // Rewind
                            Button(action: {
                                playerManager.seekBackward(15)
                            }) {
                                Image(systemName: "gobackward.15")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            
                            // Play/Pause
                            Button(action: {
                                playerManager.togglePlayPause()
                                isPlaying.toggle()
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            // Forward
                            Button(action: {
                                playerManager.seekForward(15)
                            }) {
                                Image(systemName: "goforward.15")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            
                            // Speed Control
                            Menu {
                                ForEach([0.5, 0.75, 1.0, 1.25, 1.5, 2.0], id: \.self) { speed in
                                    Button("\(speed)x") {
                                        playerManager.setPlaybackRate(Float(speed))
                                    }
                                }
                            } label: {
                                Text("\(String(format: "%.1f", playerManager.playbackRate))x")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.6))
                                    .cornerRadius(8)
                            }
                            
                            // Mute
                            Button(action: {
                                playerManager.toggleMute()
                            }) {
                                Image(systemName: playerManager.isMuted ? "speaker.slash.fill" : "speaker.fill")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
        }
        .onAppear {
            playerManager.loadVideo(url: videoURL)
            startControlsTimer()
        }
        .onDisappear {
            playerManager.cleanup()
        }
        .statusBar(hidden: true)
    }
    
    private func toggleControls() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showControls.toggle()
        }
        if showControls {
            startControlsTimer()
        } else {
            controlsTimer?.invalidate()
        }
    }
    
    private func startControlsTimer() {
        controlsTimer?.invalidate()
        controlsTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                showControls = false
            }
        }
    }
}

                            // Custom Slider for better control
struct CustomSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let onEditingChanged: (Bool) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background Track
                Rectangle()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(height: 3)
                
                // Progress Track
                Rectangle()
                    .foregroundColor(.red)
                    .frame(width: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width, height: 3)
                
                // Thumb
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .offset(x: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width - 7.5)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                onEditingChanged(true)
                                let newValue = min(max(range.lowerBound, Double(gesture.location.x / geometry.size.width) * (range.upperBound - range.lowerBound) + range.lowerBound), range.upperBound)
                                value = newValue
                            }
                            .onEnded { _ in
                                onEditingChanged(false)
                            }
                    )
            }
        }
    }
}
