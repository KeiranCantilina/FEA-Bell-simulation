library(seewave)
library(tuneR)

wav_source_dir <- "C://Users//Keiran//Desktop//Bourdon.wav"

wav_source <- readWave(wav_source_dir)

spectrum <- spec(wav_source, wl=8192,norm=TRUE,at=2,flim =c(0,2))

peaks <- as.data.frame(fpeaks(spectrum, f=44100, nmax=NULL, freq = 50, threshold = .008))
wav_synth <- 0

for(i in 1:length(peaks$freq)){
  wav_synth <- wav_synth + synth(f=44100, d=2, cf=1000*(peaks$freq[i]), a=peaks$amp[i], signal = "sine")
}

listen(wav_synth, f=44100)

