
%% Control Function Generator

clear f;

f = fgen('USB0::0x0957::0x1507::MY48006296::0::INSTR'); %%Function Generators Physical Address

f.disableOutput;

f.Waveform = "Sine";
f.Amplitude = 0.1;

%% Frequency Sweep

f.Amplitude = 0.04;  % 40mV peak-to-peak

f.enableOutput;
for i = 1:1000       % Sweeps 1 to 100 Hz
    f.Frequency = 0.1*i;
end

f.disableOutput;

%% Amplitude Sweep

f.Amplitude = 0.1;
f.Frequency = 1;

f.enableOutput;

%Frequency = linspace(1, 200, 1000);

shift = -100;

for i = 1:1000
    %Amplitudes(i) = AmplitudeProfile((64*i)+63);
    index = 64*i;
    if index-shift<1
        index = 1;
    elseif index-shift>length(AmplitudeProfile)
        index = length(Amplitudes);
    else
        index = index - shift;
    end
    Amplitudes(i) = AmplitudeProfile(index);
end

for i = 1:1000
    f.Frequency = 0.2*i;
    f.Amplitude = Amplitudes(i);
    %f.Amplitude = 0.2;
end

f.disableOutput
