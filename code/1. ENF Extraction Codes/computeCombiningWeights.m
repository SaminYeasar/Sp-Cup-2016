function [ weights] = computeCombiningWeights( signal0, fs, harmonics, duration, frame_size_secs, overlap_amount_secs, nfft, nominal, width_signal, width_band )
%COMPUTECOMBININGWEIGHTS Summary of this function goes here
%   This function computes the Combining Weights for the Spectrum Combining
%   approach for ENF signal estimation
%   Takes as input:
%   -> signal0: ENF-containing signal.
%   -> fs: sampling frequency of 'signal0'.
%   -> harmonics: harmonics for which we want to compute weights around.
%   -> duration: time duration for which we compute a certain weight, e.g.
%   30 min
%   -> frame_size_secs: size of time-frame for which one instantaneous ENF
%   point is estimated, e.g. 5 sec.
%   -> overlap_amount_secs: nb of seconds of overlap between time-frames
%   -> nfft: Nb of points for FFT computation, e.g. 32768 for frequency
%   resolution of ~0.03Hz when fs = 1000Hz.
%   -> nominal: nominal frequency, e.g. 60Hz for US grids.
%   -> width_signal: half the width of the band which we consider contains
%   the ENF fluctutations around the nominal value, e.g. 0.02Hz for US ENF.
%   -> width_band: half the width of the band abour the nominal value,
%   which we are considering for SNR computations, e.g. 1Hz for US ENF.
%   Gives output:
%   -> spectro_strips: a Matlab Cell of size equal to the number of
%   harmonic multiples, each component contains a spectrogram strip
%   centered at one of the harmonic multiples.
%   Gives output:
%   -> weights: combining weights computed.

% setting up the variables
nb_durations = ceil(length(signal0)/(duration*60*fs));
frame_size = floor(fs*frame_size_secs);
overlap_amount = floor(fs*overlap_amount_secs);
shift_amount = frame_size - overlap_amount;
nb_of_harmonics = length(harmonics);
harmonic_multiples = harmonics/nominal;
starting_freq = nominal - width_band;
center_freq = nominal;
init_first_value = nominal - width_signal;
init_second_value = nominal + width_signal;
weights = zeros(nb_of_harmonics,nb_durations);
inside_mean = zeros(nb_of_harmonics,nb_durations);
outside_mean = zeros(nb_of_harmonics,nb_durations);
total_nb_frames = 0;
All_Strips_Cell =  cell(nb_durations, 1);

for dur = 1:nb_durations
    dur;
    x = signal0( (dur -1)*duration*60*fs + 1: min(end, dur*duration*60*fs + overlap_amount));
    
    %% getting the spectrogram 
    nb_of_frames = ceil((length(x) - frame_size + 1)/shift_amount);
    total_nb_frames = total_nb_frames + nb_of_frames;
    P = zeros(nfft/2 + 1, nb_of_frames);
    starting = 1;
    for frame = 1:nb_of_frames
        ending = starting + frame_size - 1;
        signal = x(starting:ending);
        [S F T P(:, frame)] = spectrogram(signal, frame_size, 0, nfft, fs);
        starting = starting + shift_amount;
    end
    
    %% getting the harmonic strips
    
    width_init = findClosest(F, center_freq) - findClosest(F, starting_freq);
    HarmonicStrips = zeros(width_init*2*sum(harmonic_multiples) , size(P, 2));
    FreqAxis = zeros(width_init*2*sum(harmonic_multiples), 1);
    resolution = F(2) - F(1);

    starting = 1;
    starting_indices = zeros(nb_of_harmonics,1);
    ending_indices = zeros(nb_of_harmonics,1);
    for k = 1:nb_of_harmonics
        starting_indices(k) = starting;
        width = width_init*harmonic_multiples(k);
        ending = starting + 2*width -1;
        ending_indices(k) = ending;
        tempFreqIndex = round(harmonics(k)/resolution);
        HarmonicStrips(starting:ending, :) = P((tempFreqIndex - width + 1):(tempFreqIndex + width), :);
        FreqAxis(starting:ending) = F((tempFreqIndex - width + 1):(tempFreqIndex + width));
        starting = ending + 1;
    end
    
    All_Strips_Cell{dur} = HarmonicStrips;
    %% getting the weights
    
    for k = 1:nb_of_harmonics
        currStrip = HarmonicStrips(starting_indices(k):ending_indices(k),:);
        freq_axis = FreqAxis(starting_indices(k):ending_indices(k));
        first_value = init_first_value*harmonic_multiples(k);
        second_value = init_second_value*harmonic_multiples(k);
        first_index = findClosest(freq_axis, first_value);
        second_index = findClosest(freq_axis, second_value);
        inside_strip = currStrip(first_index:second_index, :);
        inside_mean(k, dur) = mean(mean(inside_strip));
        outside_strip = currStrip([1:first_index-1, second_index +1:end], :);
        outside_mean(k, dur) = mean(mean(outside_strip));
        if inside_mean(k, dur) < outside_mean(k, dur)
            weights(k, dur) = 0;
        else
            weights(k, dur) = inside_mean(k, dur)/outside_mean(k, dur);
        end
        
    end
    
    %% normalizing the weights
    sum_weights = sum(weights(:, dur));
    for k = 1:nb_of_harmonics
        weights(k, dur) = 100*weights(k, dur)/sum_weights;
    end
end
end