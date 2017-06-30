function [ spectro_strips, frequency_support ] = computeSpectrogramStrips( signal, frame_size_secs, overlap_amount_secs, nfft, fs, nominal, harmonic_multiples, width_band )
%COMPUTESPECTROGRAMSTRIPS Summary of this function goes here
%   This function generates the spectrogram strips needed for ENF signal estimation
%   Takes as input: 
%   -> signal: ENF-containing signal.
%   -> frame_size_secs: size of time-frame for which one instantaneous ENF
%   point is estimated, e.g. 5 sec.
%   -> overlap_amount_secs: nb of seconds of overlap between time-frames
%   -> nfft: Nb of points for FFT computation, e.g. 32768 for frequency
%   resolution of ~0.03Hz when fs = 1000Hz.
%   -> fs: sampling frequency of 'signal'.
%   -> nominal: nominal frequency of ENF signal, e.g. 60Hz in US.
%   -> harmonic_multiples: harmonic multiples for which we want to compute
%   the spectrogram strips for, e.g. 1:8 for 60, 120, 180, ... , 480Hz.
%   -> width_band: half the desired width of the strips, about the nominal
%   frequency.
%   Gives output:
%   -> spectro_strips: a Matlab Cell of size equal to the number of
%   harmonic multiples, each component contains a spectrogram strip
%   centered at one of the harmonic multiples.
%   -> frequency_support: index of starting and ending frequencies of each
%   strip.

% setting up the variables
nb_harmonics = length(harmonic_multiples);
spectro_strips = cell(nb_harmonics, 1);
frame_size = frame_size_secs*fs;
overlap_amount = overlap_amount_secs*fs;
shift_amount = frame_size - overlap_amount;
len_sig = length(signal);
nb_frames = ceil((len_sig - frame_size + 1)/shift_amount);

% collecting the full spectrogram in P, and the full frequency axis in F
starting = 1;
P = zeros(nfft/2 + 1, nb_frames);
for frame = 1:nb_frames
    ending = starting + frame_size - 1;
    x = signal(starting:ending);
    [~, F, ~, P(:, frame)] = spectrogram(x, frame_size, 0, nfft, fs);
    starting = starting + shift_amount;
end


% choosing the strips that we need, and setting up 'frequency_support'.
first_index = findClosest(F, nominal - width_band);
second_index = findClosest(F, nominal + width_band);
frequency_support = zeros(nb_harmonics, 2);
for k = 1:nb_harmonics
    starting = first_index*harmonic_multiples(k);
    ending = second_index*harmonic_multiples(k);
    spectro_strips{k} = P(starting:ending, :);
    frequency_support(k, 1) = F(starting);
    frequency_support(k, 2) = F(ending);
end

end