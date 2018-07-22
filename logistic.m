%initial parameter----------
r=3.62;
x=0.7;
N=1000;
k=14;
g=2^k;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%taking input of the original image
v=imread('D:\4.2.01.png');
a=rgb2gray(v);
ab1=a(:);
quant=zeros(256,1);
for i=1:size(ab1,1);
     quant(ab1(i)+1)=quant(ab1(i)+1)+1;
end;
ab=a(:);
X=zeros(size(a,1)*size(a,2),1);
sise=size(a,1)*size(a,2)+N;
for i=1:sise;
       %logistic map implementation
       X(i,1)=r*x*(1-x)*g-floor(r*x*(1-x)*g);
       %modified logistic map
       X(i,1)=mod((1000*(X(i)+abs(X(i)))),1);
       x=X(i,1);
       %percentage of total sequence generated
       p1=((i)/(size(a,1)*size(a,2)+N)*100)
end;
%ignoring the first N elements
X=X(N+1:end,:);
%generation of permutation matrix: X_prime
[useless,X_prime]=sort(X);
a_prime=zeros(size(a,1)*size(a,2),1);
for i=1:size(a,1)*size(a,2);
    %generation of permuted image pixel
    a_prime(i,1)=ab(X_prime(i,1),1);
    %percentage of permutation image pixels generated
    p2=i/(size(a,1)*size(a,2))*100
end;
%f is the 
f=reshape(uint8(a_prime),size(a,1),size(a,2));
%image generated after permutation
figure(1):imshow(f);
%generation of diffusion matrix
d_prime=uint8(mod(floor((X)*(10^14)),256));
h=uint8(d_prime(:));
C=uint8(zeros(size(a,1)*size(a,2),1));
C2=uint8(zeros(size(C)));
%obtaining the encrypted image
%----
C=h(1);
for i=2:size(a,1)*size(a,2);
C(i)=bitxor(uint8(mod(a_prime(i)+h(i),256)),uint8(C(i-1)));
end;
%----
%viewing the encrypted image
s=reshape(uint8(C),size(a,1),size(a,2));
figure(2):imshow(s);
%saving the encrypted image
imwrite(s,'D:\enc.png');
ab2=s(:);
quant1=zeros(256,1);
for i=1:size(ab2,1);
     quant1(ab2(i)+1)=quant1(ab2(i)+1)+1;
end;
final_img1=uint8(zeros(size(a,1)*size(a,2),1));
final_img2=uint8(zeros(size(a,1)*size(a,2),1));
final_img(1)=C(1);
for i=2:size(a,1)*size(a,2);
C(i)=bitxor(uint8(mod(a_prime(i)+h(i),256)),uint8(C(i-1)));
end;
for i=1:size(a,1)*size(a,2);
    final_img2(X_prime(i,1),1)=a_prime(i);
    p3=i/(size(a,1)*size(a,2))*100
end;
w=reshape(uint8(final_img2),size(a,1),size(a,2));
figure(3):imshow(w);
imwrite(w,'D:\dcy.png');
figure(4):bar(1:size(quant,1),quant);
figure (5): bar(1:size(quant1,1),quant1);

%Finding the correlation of adjacent pixels-------------
A=double(a);
A2=double(s);
%horizontal
x1 = A(:,1:end-1);  
y1 = A(:,2:end);
kyatayO=hesap(x1,y1)
%Vertical
x2 = A(1:end-1,:);  
y2 = A(2:end,:);    
kdikeyO=hesap(x2,y2)
%diagonal
x3 = A(1:end-1,1:end-1);  
y3 = A(2:end,2:end);     
kkosegenO=hesap(x3,y3)

%==================================================
%for encrypted image
%horizontal
x4 = A2(:,1:end-1);  
y4 = A2(:,2:end);
kyatayI=hesap(x4,y4)
%Vertical
x5 = A2(1:end-1,:);  
y5 = A2(2:end,:);    
kdikeyI=hesap(x5,y5)
%diagonal
x6 = A2(1:end-1,1:end-1);  
y6 = A2(2:end,2:end);     
kkosegenI=hesap(x6,y6)
%==================================================
%graphics
h=figure;
subplot(3,2,1),grafik(x1,y1),title('Horizontal');
subplot(3,2,3),grafik(x2,y2),title('Vertical');
subplot(3,2,5),grafik(x3,y3),title('Diagonal');
subplot(3,2,2),grafik(x4,y4),title('Horizontal');
subplot(3,2,4),grafik(x5,y5),title('Vertical');
subplot(3,2,6),grafik(x6,y6),title('Diagonal');
saveas(h,'correlationGray.jpg');
%correlation ends here-----------------------------
%---------------------------------------------------
%psnr values finding out
% org=A;
% dimg=double(w);
% [M N]=size(org);
% error=org-dimg;
% MSE=sum(sum(error.*error))/(M*N);
% if(MSE>0)
%     PSNR=10*log(255*255/MSE)/log(10)
% else
%     PSNR=99
% end