function [ENF] = computeENFfromCombinedStrip( OurStrip_Cell, initial_frequency, fs, nfft  )
%COMPUTEENFFROMCOMBINEDSTRIP Summary of this function goes here
%   This function computes the ENF signal estimate from the combined strip
%   Takes as input:
%   -> OurStrip_Cell: Cell containing the combined strip for different
%   durations.
%   -> initial_frequency: the frequency to which the first column in the
%   combined strip corresponds to.
%   -> fs: sampling frequency.
%   -> nfft: Nb of points for FFT computation, e.g. 32768 for resolutoon of
%   ~0.03Hz when fs = 1000Hz.

% setting up the variables
nb_durations = length(OurStrip_Cell);
nb_frames_per_dur = size(OurStrip_Cell{1}, 2);
nb_frames = nb_frames_per_dur*(nb_durations - 1) + size(OurStrip_Cell{end},2);
ENF = zeros(nb_frames, 1);

% taking each frame at a time, and using quadratic interpolation to find
% its maximum and thus its dominant ENF frequency

starting = 1;
for dur = 1:nb_durations
    OurStrip_here = OurStrip_Cell{dur};
    nb_frames_here = size(OurStrip_here, 2);
    ending = starting + nb_frames_here - 1;
    ENF_here = zeros(nb_frames_here, 1);
    for frame = 1:nb_frames_here
        power_vector = OurStrip_here(:, frame);
        [~, index] = max(power_vector);
        k_star = QuadInterpFunction(power_vector, index);
        ENF_here(frame) = initial_frequency + fs*k_star/nfft;
    end
    ENF(starting:ending) = ENF_here;
    starting = ending + 1;
end
end