function [ pseudo_spectra_strips, frequency_support ] = computePseudoSpectrumStrips( signal, filters, frame_size_secs, overlap_amount_secs, nfft, fs, nominal, harmonic_multiples, width_band  )
%COMPUTEPSEUDOSPECTRUMSTRIPS Summary of this function goes here
%   This function generates the pseudo-spectrum strips needed for ENF signal estimation
%   Takes as input: 
%   -> signal: ENF-containing signal.
%   -> filters: Matlab Cell containing band-pass filters centered about the
%   desired harmonics.
%   -> frame_size_secs: size of time-frame for which one instantaneous ENF
%   point is estimated, e.g. 5 sec.
%   -> overlap_amount_secs: nb of seconds of overlap between time-frames
%   -> nfft: Nb of points for FFT computation, e.g. 32768 for frequency
%   resolution of ~0.03Hz  when fs = 1000Hz.
%   -> fs: sampling frequency of 'signal.
%   -> nominal: nominal frequency of ENF signal, e.g. 60Hz in US.
%   -> harmonic_multiples: harmonic multiples for which we want to compute
%   the spectrogram strips for, e.g. 1:8 for 60, 120, 180, ... , 480Hz.
%   -> width_band: half the desired width of the strips, about the nominal
%   frequency.
%   Gives output:
%   -> pseudo_spectra_strips: a Matlab Cell of size equal to the number of
%   harmonic multiples, each component contains a pseudospectrum strip
%   centered at one of the harmonic multiples.
%   -> frequency_support: index of starting and ending frequencies of each
%   strip.

% setting up the variables
nb_harmonics = length(filters);
pseudo_spectra_strips = cell(nb_harmonics, 1);
signals = filter_signals(signal, filters, 1:nb_harmonics);
frame_size = frame_size_secs*fs;
overlap_amount = overlap_amount_secs*fs;
shift_amount = frame_size - overlap_amount;
len_sig = length(signal);
nb_frames = ceil((len_sig - frame_size + 1)/shift_amount);
frequency_support = zeros(nb_harmonics, 2);

% computing full pseudo-spectrum of each filtered signal, then choosing out
% the strips needed.
for k = 1:nb_harmonics
        x = signals{k};
        pseudo_temp = zeros(nfft/2 + 1, nb_frames);
        starting = 1;
        for frame = 1:nb_frames
            ending = starting + frame_size -1;
            [S, f] = pmusic(x(starting:ending), 2, nfft, fs, 50, 49);
            pseudo_temp(:, frame) = S;   
            starting = starting + shift_amount;
        end
        
        first_index = findClosest(f, nominal - width_band);
        second_index = findClosest(f, nominal + width_band);
        
        starting = first_index*harmonic_multiples(k);
        ending = second_index*harmonic_multiples(k);
        pseudo_spectra_strips{k} = pseudo_temp(starting:ending, :);
        frequency_support(k, 1) = f(starting);
        frequency_support(k, 2) = f(ending);
        clear pseudo_temp
end

