clear
H=[0.2-1j*0.8, 0.5+1j*0.3, 0.1-1j*0.1;
    1.2+1j*0.5, 0.6 , 1.3+1j*0.7 ;
    0.4+1j*0.2, 0.2-1j*0.4, 1-1j]; 
Sr=[-0.18-1j*1.21;
    1.87+1j*1.21;
    1.28-1j*0.44];
% 
% B= pinv(H); % MMSE 
% 
% a=sum(abs(B).^2,2);
% [~,k]=min(sum(abs(B).^2,2));          % argmin 
% Co=[];
% for ii = 1:1:3 
%     Co(k)=B(k,:)*Sr;
%     R= slice( Co(k), 'BPSK' );  
%     Sr=Sr-H(:,k)*R;
%     H(:,k)=0;
%     B= pinv(H); % MMSE 
%     V1=sum(abs(B).^2,2);
%     v=V1;
%     v(V1==0) = NaN; 
%     [~,k]=min(v);
% end
% display(Co)
% x=[0,1];
% symbin = pskmod(x,2 ) ;  %Modular todos os todos os possiveis simbolos    
% 
values = [-1 1 ];                            %//  data
k = 3;                                      %//  data
n = numel(values);                          %//  number of values
combs = values(dec2base(0:n^k-1,n)-'0'+1)   %//  generate all tuples
% % B=3
% [Out{1:3}]=ndgrid(symbin);
% Out=reshape( cat(B+1,Out{:}),[],B)
% 
% 
% 

% 

% M=16;
% x = (0:M-1); %Gerar todos os possiveis simbolos
% symbin = qammod(x,M )   %Modular todos os todos os possiveis simbolos  
% combs=combnk(symbin,2)

Sum=zeros(1,[]);

for ii=1:1:length(combs)
    suma = sum(abs(Sr - H*combs(ii,:).').^2);
    Sum(ii)=suma;
end
[~, k]= min(Sum); 
C_dem = combs(k,:);
 