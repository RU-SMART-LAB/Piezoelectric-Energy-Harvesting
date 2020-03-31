fileName = freqrespDatPiezo45;
f = table2array(fileName);
frequency = f(:,1); %all rows in first column
peakVoltage = f(:, 2); %all rows in second column, peak voltage
[upperVoltage, lowerVoltage] = envelope(peakVoltage);
vMag = peakVoltage/2;
[upper, lower] = envelope(vMag);
upper2 = movmean(upper, 20);
figure(1);
plot(frequency, vMag)
figure(2);
plot(frequency, upper)
figure(3);
hold on
plot(frequency, upper2)
[m, maxIndex] = max(vMag);
disp("max: " + m + ", index: " + i)
target =m*0.708   %half of max value - find frequency at this value

found = false;
i = 1;
while ~found
    val = upperVoltage(i);
    if val > target
        previousVal = upperVoltage(i-1);
        difference1 = abs(target-previousVal);
        difference2 = abs(target-val);
        if(difference1 < difference2)
            found = true;
            index = i-1;
        else
            index = i;
        end
    end
    i = i+1;
end
disp("index of max*.708 = " + index)
disp("value of frequency: " + frequency(index))

plot(frequency(index), upperVoltage(index), )

found = false;
i = maxIndex;
while ~found
    val = upperVoltage(i);
    if val < target
        previousVal = upperVoltage(i-1);
        difference1 = abs(target-previousVal);
        difference2 = abs(target-val);
        if(difference1 < difference2)
            found = true;
            index = i-1;
        else
            index = i;
        end
    end
    i = i+1;
end
disp("lower index of max*.708 = " + index)
disp("lower value of frequency: " + frequency(index))

plot(frequency(index), upperVoltage(index), 'r*')
hold off





    
