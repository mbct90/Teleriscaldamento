function [Qff,Q,dP,flag2,P12_c,P3_c,Q2_c,Qu_c]=caratteristicaImpiantoRegolazioniTempo(Qfin,Pfin,Piniz,par_r,u1,u2,Qreg,p_pompa,p_rendimento)
% Qfin e Pfin dipendono dalle specifiche della pompa

Q= [0.1:0.5:Qfin];
dP=[0.0:0.5:Pfin];
P3=Piniz;

for j=1:length(dP)
    for k=1:length(Q)
        
        P12=dP(j);
        Q2=Q(k);
        
        
        for i=1:length(par_r(:,1))
            if(i==8)
                [Qu(i),Qu(i+1),Q2(i+1),P12(i+1),P3(i+1)]=...
                    perditaCaricoRegolazioni_doppio(par_r(i,:),u1,u2,Q2(i),P12(i),P3(i),Qreg(i),Qreg(i+1));
            else
                if (i==9)
                    Q2(i+1)=Q2(i);
                    P3(i+1)=P3(i);
                    P12(i+1)=P12(i);
                else
                    [Qu(i),Q2(i+1),P12(i+1),P3(i+1)]=...
                        perditaCaricoRegolazioni(par_r(i,:),Q2(i),P12(i),P3(i),Qreg(i));
                end
            end
        end
        P12_vec(k,:)=P12;
        P3_vec(k,:)=P3;
        Q2_vec(k,:)=Q2;
        Qu_vec(k,:)=Qu;
        
        if Qu>=Qreg'
            flag1(k)=1;
        else
            flag1(k)=0;
        end
        
        Qfin(k)=Q2(end);
    end
    [qmin(j),r(j)]=min(abs(Qfin));
    flag2(j)=flag1(r(j));
    
    Qff(j)=Q(r(j));
    P12_c(j,:)=P12_vec(r(j),:);
    P3_c(j,:)=P3_vec(r(j),:);
    Q2_c(j,:)=Q2_vec(r(j),:);
    Qu_c(j,:)=Qu_vec(r(j),:);
    
end

% for i=1:length(dP)
%     Qff(i)=Q(r(i));
% end

end
