
function[number]=Eavesdrop(audiofilename)
    finaldata=zeros(44100,10);
    s='.ogg';
    for i=0:9
        a=strcat(num2str(i),s);
 
    finaldata(:,i+1) = abs(fft(audioread(a)));
    end
    
    for i=1:10
        finaldata(:,i)=finaldata(:,i)/norm(finaldata(:,i));
    end
    
    information = audioinfo(audiofilename);
    Sr = information.SampleRate;
    total = information.TotalSamples;
    number=[];


    for Pointstart = 1:Sr:total
        Pointend = min(Pointstart + Sr - 1, total);
        y = audioread(audiofilename, [Pointstart Pointend]);
        y=abs(fft(y));
        y=y/norm(y);
        max_val=0;
        digit=0;
        for i=1:10
            temp=xcorr(y,finaldata(:,i),0,'coeff');
            if temp>max_val
                max_val=temp;
                digit=(i-1);
            end
        end
        number=[number,digit];
    end
end
