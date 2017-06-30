function [ OurStrip_Cell, initial_frequency ] = computeCombinedSpectrum( strips, weights, duration, frame_size_secs, strip_index, frequency_support )
%   COMPUTECOMBINEDSPECTRUM Summary of this function goes here
%   This function takes in spectrogram strips, or pseudo-spectrum strips
%   and combines them according to the combining weights.
%   Takes as input:
%   -> strips: Cell containing strips around different harmonics.
%   -> weights: combining weights.
%   -> duration: time-duration for which a certain weight is computed.
%   -> frame_size_secs: size of time-frame for which one instantaneous ENF
%   point is estimated, e.g. 5 sec.
%   -> strip_index: index of the strip in 'strips' whose width will be 
%   the width we give to all the strips when we combine them.
%   -> frequency_support: beginning and ending frequencies for each strip
%   Gives as output:
%   -> OurStrip_cell: Cell of size corresponding to the number of
%   durations, containing the combined strip for each duration.
%   -> initial_frequency: starting frequency of combined strip

% setting up the variables
nb_durations = size(weights, 2);
nb_frames = size(strips{1}, 2);
nb_frames_per_dur = duration*60/frame_size_secs;
strip_width = size(strips{strip_index}, 1);
OurStrip_Cell = cell(nb_durations, 1);
nb_signals = length(strips);
initial_frequency = frequency_support(strip_index, 1);

% combining the strips, taking each duration at a time, as each duration
% has a different set of weights.
begin = 1;
for dur = 1:nb_durations
    nb_frames_left = nb_frames - (dur-1)*nb_frames_per_dur;
    OurStrip = zeros(strip_width, min(nb_frames_per_dur, nb_frames_left));
    endit = begin + size(OurStrip,2) -1;
    for harm = 1:nb_signals
        tempStrip = strips{harm}(:, begin:endit);
        for frame = 1:size(OurStrip, 2)
            tempo = imresize(tempStrip(:, frame), [strip_width, 1], 'bilinear');
            tempo = 100*tempo/max(tempo);
            OurStrip(:, frame) = OurStrip(:, frame) + weights(harm, dur)*tempo;
        end
    end
    OurStrip_Cell{dur} = OurStrip;
    begin = endit +1 ;
end
end