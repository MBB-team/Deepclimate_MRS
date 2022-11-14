function [finalindexletter]=NS_SequenceOfLetterTS(lseq)
%%% warning : be sure your sequence can be divided by 4
%lseq=24;
%Random type of letter
indexvoymintmp=7:12;
indexvoymajtmp=1:6;
indexconsmintmp=19:24;
indexconsmajtmp=13:18;
index2voymin=randperm(6);
index2voymaj=randperm(6);
index2consmin=randperm(6);
index2consmaj=randperm(6);
if lseq < 24
    %% elemantaryindexletter
    index2voymin=randperm(6);
    index2voymaj=randperm(6);
    index2consmin=randperm(6);
    index2consmaj=randperm(6);
    indexvoymin=indexvoymintmp(index2voymin(1:3));
    indexvoymaj=indexvoymajtmp(index2voymaj(1:3));
    indexconsmin=indexconsmintmp(index2consmin(1:3));
    indexconsmaj=indexconsmajtmp(index2consmaj(1:3));
    indexletter=[];
    for curseur=1:3
        letterindextmp=[indexvoymin(curseur) indexvoymaj(curseur) indexconsmin(curseur) indexconsmaj(curseur)];
        letterindex2tmp=randperm(4);
        indexletter=[indexletter letterindextmp(letterindex2tmp(1)) letterindextmp(letterindex2tmp(2))...
            letterindextmp(letterindex2tmp(3)) letterindextmp(letterindex2tmp(4))];
    end
    elementaryindexletter=indexletter;%12
else
    %% elemantaryindexletter
    index2voymin=randperm(6);
    index2voymaj=randperm(6);
    index2consmin=randperm(6);
    index2consmaj=randperm(6);
    indexvoymin=indexvoymintmp(index2voymin(1:6));
    indexvoymaj=indexvoymajtmp(index2voymaj(1:6));
    indexconsmin=indexconsmintmp(index2consmin(1:6));
    indexconsmaj=indexconsmajtmp(index2consmaj(1:6));
    indexletter=[];
    for curseur=1:6
        letterindextmp=[indexvoymin(curseur) indexvoymaj(curseur) indexconsmin(curseur) indexconsmaj(curseur)];
        letterindex2tmp=randperm(4);
        indexletter=[indexletter letterindextmp(letterindex2tmp(1)) letterindextmp(letterindex2tmp(2))...
            letterindextmp(letterindex2tmp(3)) letterindextmp(letterindex2tmp(4))];
    end
    elementaryindexletter=indexletter;%12
end
if lseq-12 < 12
    lseqsupp=(lseq-12)/4;
else
    lseqsupp=(lseq-24)/4;
end
supplementaryindexletter=[];
if lseqsupp>0
    %% supplementaryindexletter
    
    index2voymin=randperm(6);
    index2voymaj=randperm(6);
    index2consmin=randperm(6);
    index2consmaj=randperm(6);
    indexvoymin=indexvoymintmp(index2voymin(1:lseqsupp));
    indexvoymaj=indexvoymajtmp(index2voymaj(1:lseqsupp));
    indexconsmin=indexconsmintmp(index2consmin(1:lseqsupp));
    indexconsmaj=indexconsmajtmp(index2consmaj(1:lseqsupp));
    indexletter=[];
    for curseur=1:lseqsupp
        letterindextmp=[indexvoymin(curseur) indexvoymaj(curseur) indexconsmin(curseur) indexconsmaj(curseur)];
        letterindex2tmp=randperm(4);
        indexletter=[indexletter letterindextmp(letterindex2tmp(1)) letterindextmp(letterindex2tmp(2))...
            letterindextmp(letterindex2tmp(3)) letterindextmp(letterindex2tmp(4))];
    end
    supplementaryindexlettertmp=indexletter;%12
    supplementaryindexletter=[supplementaryindexletter supplementaryindexlettertmp];%indexletter;%12
    
end
finalindexletter=[elementaryindexletter supplementaryindexletter];


%%check
% letters={'A' 'E' 'I' 'O' 'U' 'Y' 'a' 'e' 'i' 'o' 'u' 'y'...
%     'B' 'C' 'G' 'K' 'M' 'P' 'b' 'c' 'g' 'k' 'm' 'p'};
% letters(finalindexletter)




