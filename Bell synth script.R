library(seewave)
library(tuneR)
library(fftw)

wav_source_dir <- "C://Users//Keiran//Desktop//C1.wav"

wav_source <- readWave(wav_source_dir)
output <- 0
output <- addsilw(output, 44100, at="start", d=0.1)
amplitude_fundamental <- 0
peak_record <- 0



for (j in 0:90){
  spectrum <- spec(wav_source, wl=8192,norm=FALSE,scaled=FALSE, PMF=FALSE, at=(j/10)+0.1, plot = FALSE, fftw=TRUE)
  peaks <- as.data.frame(fpeaks(spectrum, f=44100, nmax=10, plot = FALSE))
  peaks$amp <- peaks$amp/6000000

  wav_synth <- 0
  
  for(i in 1:length(peaks$freq)){
    wav_synth <- wav_synth + synth(f=44100, d=0.035, cf=1000*(peaks$freq[i]), a=peaks$amp[i], signal = "sine")
  }
  amplitude_fundamental <- c(amplitude_fundamental, max(peaks$amp))
  output <- pastew(wav_synth, output, 44100, join=TRUE, at="end")
  
}


listen(output, f=44100)
spectro(output, f=44100, flim=c(0,4))
