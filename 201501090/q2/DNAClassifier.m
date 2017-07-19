function[species]=DNAClassifier(DNA)
    load('AncestorData.mat');
    value1=Similar(DNA,chimps);
    value2=Similar(DNA,humans);
    value3=Similar(DNA,rhesus);
    % print m(ax value
    mval = max([value1, value2, value3]);
    if mval == value2
        species = 'Human';
    elseif mval == value3
        species = 'Rhesus';
    else
        species = 'Chimp';
    end
end

function[value]=Similar(input,species)
    inp=[];
    f_species=[];
    for i=1:4
        a=abs(fft(input(i,:)));
        a=a/norm(a);
        inp=[inp;a];
        b=abs(fft(species(i,:)));
        b=b/norm(b);
        f_species=[f_species;b];
    end
    value=1;
    for i=1:4
            value=value*(inp(i,:)*transpose(f_species(i,:)));
    end
end