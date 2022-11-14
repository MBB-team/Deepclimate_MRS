function [colortype,seq] = NS_randcolortype_free(totaltrials,nbofswitch)
%clear all;%%%%%%%%%%%%

%totaltrials=384;%%%%%%%
%nbofswitch=27;%%%%%%%%%

range=floor(totaltrials/5);
proba=nbofswitch/totaltrials;%range;
seqswitch=[];
nbswitch=0;
switchper50=zeros(1,5);
seq=0;
crit=0;
while crit== 0
    
    seq=rand(1,totaltrials);   
    nbswitch=sum(seq<=proba);    
    nbswitch1=0;
    % account of three consecutive switch (what we don't want)
    for a=1:totaltrials
        if a>2 & a<totaltrials & seq(a)~= seq(a-1) & seq(a)~= seq(a+1) & seq(a)== seq(a-2)
            nbswitch1=nbswitch1+1;
        elseif a>1 & a<(totaltrials-2) & seq(a)~= seq(a-1) & seq(a)~= seq(a+1) & seq(a)== seq(a+2)
            nbswitch1=nbswitch1+1;
        end
    end
    if nbswitch==nbofswitch & seq(1)>proba % %&& nbswitch1 > 0
        crit=1;
    end

    
end   


startcolortype=randperm(2); % determine randomly the first color

%indexswitch=find(seqswitch<=(nbofswitch/range));
indexswitch=find(seq<=proba);
% %Verification
b1=0;
b4=0;
colortype=zeros(1,totaltrials)+startcolortype(1);

for a=1:length(indexswitch)
    if mod(a,2)~=0 && a~=length(indexswitch)%odd and not the last a
        b1=b1+1;
        colortype(indexswitch(a):(indexswitch(a+1)-1))=startcolortype(2);
                                                 %-1 
    elseif mod(a,2)~=0 && a==length(indexswitch)
        b4=b4+1;        
        colortype((indexswitch(a)):length(seq))=startcolortype(2);
    end
end
length(indexswitch);
% seq
% proba
% colortype